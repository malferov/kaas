variable "sw_access_key" {}
variable "sw_secret_key" {}
variable "sw_project_id" {}

provider "scaleway" {
  access_key = var.sw_access_key
  secret_key = var.sw_secret_key
  project_id = var.sw_project_id
  region     = "nl-ams"
  zone       = "nl-ams-1"
}