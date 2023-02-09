



resource "google_service_account" "gke_sa" {
  account_id = "gke-cluster-sa"
}


resource "google_project_iam_member" "cluster-service-account-role" {
  project = var.project
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}








resource "google_container_cluster" "restricted_cluster" {
  name               = "restricted-cluster"
  location           = "us-central1-a"
  initial_node_count = "2"

   remove_default_node_pool = true

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes = true
    master_ipv4_cidr_block = var.master_ipv4
  }

  network_policy {
    enabled = true
  }
  
  ip_allocation_policy {
    cluster_ipv4_cidr_block = var.cluster_ipv4
    services_ipv4_cidr_block = var.services_ipv4
  }

  network = var.vpc
  subnetwork = var.restricted-subnet-link
  


 master_authorized_networks_config {
    cidr_blocks {
      display_name = "management-subnet"
      cidr_block = "10.0.0.0/24"
    }
  }
    node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write"
    ]

    service_account = google_service_account.gke_sa.email
  }
}


resource "google_container_node_pool" "restricted_nodes" {
  name       = "restricted-nodes"
  cluster    = google_container_cluster.restricted_cluster.name
  location   = "us-central1-a"
  node_count = "2"
  
  node_config {
    
    image_type   = "COS_CONTAINERD"
    machine_type = "e2-micro"
    service_account = google_service_account.gke_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write"
    ]
  }
}
  







