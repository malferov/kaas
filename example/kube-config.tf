variable "kube_endpoint" {}
variable "master_user" {}
variable "master_pass" {}

locals {
  kube_config = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://${var.kube_endpoint}
  name: kube
contexts:
- context:
    cluster: kube
    user: admin
  name: kube
current-context: kube
kind: Config
preferences: {}
users:
- name: admin
  user:
    username: ${var.master_user}
    password: ${var.master_pass}
KUBECONFIG
}

resource "local_file" "kube_config" {
  content  = local.kube_config
  filename = ".kube/config"
}
