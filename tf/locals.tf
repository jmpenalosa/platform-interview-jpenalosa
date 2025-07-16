locals {
  providers = {
    development = "vault.vault_dev"
    stage       = "vault.vault_stage"
    production  = "vault.vault_prod"
  }

  vault_addrs = {
    development = "http://vault-development:8200"
    stage       = "http://vault-stage:8200"
    production  = "http://vault-production:8200"
  }

  networks = {
    development = "vagrant_development"
    stage       = "vagrant_stage"
    production  = "vagrant_production"
  }
}
