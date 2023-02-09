resource "google_service_account" "instance-sa" {
  account_id   = "instance-sa"
  display_name = "instance-sa"
}
resource "google_project_iam_member" "instance-sa" {
  project = var.project 
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.instance-sa.email}"
}


resource "google_compute_instance" "private_instance" {
  name         = "private-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
 tags = ["ssh"]
 service_account {
    email = google_service_account.instance-sa.email
    scopes = [ "https://www.googleapis.com/auth/cloud-platform" ]
  }
  network_interface {
    subnetwork = var.managment-subnet-link

    
  }
}



resource "google_compute_firewall" "ssh" {
  project     = var.project 
  name        = "ssh"
  network     = var.vpc
  priority    = 100
  direction   = "INGRESS"
  allow {
    protocol  = "tcp"
    ports     = ["22"]
  }
  target_tags = ["ssh"]
  source_ranges = ["0.0.0.0/0"]
}