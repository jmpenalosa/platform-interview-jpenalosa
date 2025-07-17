resource "vault_auth_backend" "userpass" {
  for_each = toset(var.environments)

  provider = (
    each.key == "development" ? vault.vault_dev :
    each.key == "staging"     ? vault.vault_staging :
    vault.vault_prod
  )

  type = "userpass"
}

resource "vault_generic_secret" "service" {
  for_each = {
    for pair in flatten([
      for env in var.environments : [
        for svc, conf in var.services : {
          key     = "${svc}_${env}"
          env     = env
          service = svc
          db_user = conf.db_user
          db_pass = conf.db_password
        }
      ]
    ]) : pair.key => pair
    if pair.service != "frontend"
  }

  provider = (
    each.value.env == "development" ? vault.vault_dev :
    each.value.env == "staging"     ? vault.vault_staging :
    vault.vault_prod
  )

  path = "secret/${each.value.env}/${each.value.service}"

  data_json = jsonencode({
    db_user     = each.value.db_user
    db_password = each.value.db_pass
  })
}

resource "vault_policy" "service" {
  for_each = vault_generic_secret.service

  provider = (
    each.value.env == "development" ? vault.vault_dev :
    each.value.env == "staging"     ? vault.vault_staging :
    vault.vault_prod
  )

  name = "${each.value.service}-${each.value.env}"

  policy = <<EOT
path "secret/data/${each.value.env}/${each.value.service}" {
  capabilities = ["list", "read"]
}
EOT
}

resource "vault_generic_endpoint" "user" {
  for_each = vault_policy.service

  provider = (
    each.value.env == "development" ? vault.vault_dev :
    each.value.env == "staging"     ? vault.vault_staging :
    vault.vault_prod
  )

  path                 = "auth/userpass/users/${each.value.service}-${each.value.env}"
  depends_on           = [vault_auth_backend.userpass[each.value.env]]
  ignore_absent_fields = true

  data_json = jsonencode({
    policies = ["${each.value.service}-${each.value.env}"],
    password = var.services[each.value.service].password
  })
}

resource "docker_container" "service" {
  for_each = {
    for pair in flatten([
      for env in var.environments : [
        for svc, conf in var.services : {
          key     = "${svc}_${env}"
          env     = env
          service = svc
          image   = conf.image
          port    = try(conf.port, null)
        }
      ]
    ]) : pair.key => pair
  }

  image = each.value.image
  name  = "${each.value.service}_${each.value.env}"

  env = each.value.service != "frontend" ? [
    "VAULT_ADDR=${local.vault_addrs[each.value.env]}",
    "VAULT_USERNAME=${each.value.service}-${each.value.env}",
    "VAULT_PASSWORD=${var.services[each.value.service].password}-${each.value.env}",
    "ENVIRONMENT=${each.value.env}"
  ] : null

  dynamic "ports" {
    for_each = each.value.service == "frontend" && each.value.port != null ? [1] : []
    content {
      internal = 80
      external = each.value.env == "development" ? 4080 : 4081
    }
  }

  networks_advanced {
    name = local.networks[each.value.env]
  }

  lifecycle {
    ignore_changes = all
  }

  depends_on = each.value.service != "frontend" ? [
    vault_generic_endpoint.user["${each.value.service}_${each.value.env}"]
  ] : []
}
