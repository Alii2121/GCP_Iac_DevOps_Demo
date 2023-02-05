output "managment-subnet-link" {

    value = google_compute_subnetwork.management-subnet.self_link
  
}

output "restricted-subnet-link" {
 
  value = google_compute_subnetwork.restricted-subnet.self_link

}

output "vpc" {

    value = google_compute_network.main-vpc.name
  
}
