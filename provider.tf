variable "account_key" {}
variable "project" {}
variable "region" {}
variable "zone" {}

provider "google" {
  credentials = var.account_key
  project     = var.project
  region      = var.region
  zone        = var.zone
}
