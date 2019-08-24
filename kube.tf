resource "google_container_cluster" "kube" {
  name               = "kube"
  location           = "${var.region}-a"
  initial_node_count = 2

  node_locations = [
    "${var.region}-b",
  ]

  master_auth {
    username = var.master_user
    password = var.master_pass
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
