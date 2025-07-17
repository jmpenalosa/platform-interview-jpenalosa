variable "environments" {
  type    = list(string)
  default = ["development", "production", "staging"]
}

variable "services" {
  type = map(object({
    db_user     = string
    db_password = string
    password    = string
    image       = string
    port        = optional(number)
  }))
  default = {
    account = {
      db_user     = "account"
      db_password = "pass-account"
      password    = "123-account"
      image       = "form3tech-oss/platformtest-account"
    }
    gateway = {
      db_user     = "gateway"
      db_password = "pass-gateway"
      password    = "123-gateway"
      image       = "form3tech-oss/platformtest-gateway"
    }
    payment = {
      db_user     = "payment"
      db_password = "pass-payment"
      password    = "123-payment"
      image       = "form3tech-oss/platformtest-payment"
    }
    frontend = {
      db_user     = ""
      db_password = ""
      password    = ""
      image       = "nginx:1.22.0-alpine"
      port        = 4080
    }
  }
}
