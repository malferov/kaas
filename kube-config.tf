variable "master_user" {}
variable "master_pass" {}

locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://${google_container_cluster.kube.endpoint}
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

resource "local_file" "kubeconfig" {
  content  = local.kubeconfig
  filename = ".kube/config"
}
