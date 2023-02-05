resource "google_container_cluster" "restricted_cluster" {
  name               = "restricted-cluster"
  location           = "us-central1-a"
  initial_node_count = "2"

 

  network_policy {
    enabled = true
  }

  subnetwork = var.restricted-subnet-link
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes = true
    master_ipv4_cidr_block = "10.0.7.0/28"
  }
}
