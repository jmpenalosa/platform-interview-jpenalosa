terraform {
  required_version = ">= 1.0.7"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
    vault = {
      version = "3.0.1"
    }
  }
}

provider "vault" {
  alias   = "vault_dev"
  address = "http://localhost:8201"
  token   = "f23612cf-824d-4206-9e94-e31a6dc8ee8d"
}

provider "vault" {
  alias   = "vault_prod"
  address = "http://localhost:8301"
  token   = "083672fc-4471-4ec4-9b59-a285e463a973"
}

provider "vault" {
  alias   = "vault_staging"
  address = "http://localhost:8401"
  token   = "809a2fwf-5324-4dw5-9b59-2093aadkfweir #IJUSTMADETHISUP
}
