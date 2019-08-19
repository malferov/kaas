variable "project" {}
variable "region" {}
variable "zone" {}

provider "google" {
  credentials = "${file(".key/account.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}
