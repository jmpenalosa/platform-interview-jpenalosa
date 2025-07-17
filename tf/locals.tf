locals {
  providers = {
    development = "vault.vault_dev"
    production  = "vault.vault_prod"
    staging     = "vault.vault_staging"
  }

  vault_addrs = {
    development = "http://vault-development:8200"
    production  = "http://vault-production:8200"
    staging     = "http://vault-staging:8200"
  }

  networks = {
    development = "vagrant_development"
    production  = "vagrant_production"
    staging     = "vagrant_staging"
  }
}
