variable "private_key" {}
variable "region" {}

locals {
  service = "kaas"
  image   = "centos-7-x64"
  size    = "s-2vcpu-4gb"
}

resource "digitalocean_ssh_key" "ssh" {
  name       = "ssh"
  public_key = file(".key/${local.service}.pub")
}

resource "digitalocean_tag" "tag" {
  name = local.service
}

resource "digitalocean_droplet" "droplet" {
  image     = local.image
  name      = local.service
  region    = var.region
  size      = local.size
  ssh_keys  = [digitalocean_ssh_key.ssh.id]
  tags      = [digitalocean_tag.tag.id]
  user_data = file("user_data.sh")
  lifecycle {
    ignore_changes = [
      user_data,
    ]
  }
}

resource "scaleway_instance_security_group" "sg" {
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port   = "22"
  }

  inbound_rule {
    action = "accept"
    port   = "6443"
  }

  inbound_rule {
    action = "accept"
    port   = "443"
  }
  inbound_rule {
    action = "accept"
    port   = "80"
  }
}

resource "scaleway_instance_ip" "ip" {}

data "template_file" "user_data" {
  template = file("user_data.sh")
  vars {
    ip = scaleway_instance_ip.ip.id
  }
}

resource "scaleway_instance_server" "srv" {
  type = "DEV1-M"
  // curl https://api-marketplace.scaleway.com/images | jq '.images[].label'
  image             = "centos_7.6"
  name              = local.service
  tags              = [local.service]
  ip_id             = scaleway_instance_ip.ip.id
  security_group_id = scaleway_instance_security_group.sg.id
  cloud_init        = data.template_file.user_data.rendered
}

resource "scaleway_account_ssh_key" "ssh" {
  name       = "ssh"
  public_key = file(".key/${local.service}.pub")
}

output "server" {
  sensitive = true
  value = scaleway_instance_server.srv.public_ip
}
