resource "google_compute_instance" "private_instance" {
  name         = "private-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    subnetwork = var.managment-subnet-link

    
  }
}
