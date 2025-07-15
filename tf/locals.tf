locals {
  providers = {
    development = "vault.vault_dev"
    production  = "vault.vault_prod"
  }

  vault_addrs = {
    development = "http://vault-development:8200"
    production  = "http://vault-production:8200"
  }

  networks = {
    development = "vagrant_development"
    production  = "vagrant_production"
  }
}
