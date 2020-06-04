variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

variable "sw_access_key" {}
variable "sw_secret_key" {}
variable "sw_organization_id" {}

provider "scaleway" {
  access_key      = var.sw_access_key
  secret_key      = var.sw_secret_key
  organization_id = var.sw_organization_id
  zone            = "fr-par-1"
}