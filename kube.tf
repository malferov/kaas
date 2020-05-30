variable "master_user" {}
variable "master_pass" {}

resource "google_container_cluster" "kube" {
  name               = "kube"
  location           = var.zone
  initial_node_count = 1

  master_auth {
    username = var.master_user
    password = var.master_pass
  }

  node_config {
    disk_size_gb = 20
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
