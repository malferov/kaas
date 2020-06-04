variable "public_key" {}

locals {
  service = "kaas"
  image   = "centos_7.6"
  type    = "DEV1-M"
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
  vars = {
    ip = scaleway_instance_ip.ip.address
  }
}

resource "scaleway_instance_server" "srv" {
  type = local.type
  // curl https://api-marketplace.scaleway.com/images | jq '.images[].label'
  image             = local.image
  name              = local.service
  tags              = [local.service]
  ip_id             = scaleway_instance_ip.ip.id
  security_group_id = scaleway_instance_security_group.sg.id
  cloud_init        = data.template_file.user_data.rendered
}

resource "scaleway_account_ssh_key" "ssh" {
  name       = "ssh"
  public_key = var.public_key
}

output "server" {
  sensitive = true
  value     = scaleway_instance_server.srv.public_ip
}
