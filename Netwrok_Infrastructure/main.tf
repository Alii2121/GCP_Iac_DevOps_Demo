############# Create A Custom VPC #############

resource "google_compute_network" "main-vpc" {
  
  project                 = "ali-marwan-project"
  name                    = "main-vpc"
  auto_create_subnetworks = false
  
  
}


############ Creation of accessable Management Subnet ############

resource "google_compute_subnetwork" "management-subnet" {
  
  name = "management-subnet"
  region = var.region
  ip_cidr_range = var.management-subnet-cidr
  network = google_compute_network.main-vpc.self_link
   
    depends_on = [
        google_compute_network.main-vpc
  ]
}


########## Creation of Private Restricted Subnet ###########

resource "google_compute_subnetwork" "restricted-subnet" {

    name = "restricted-subnet"
    region = var.region
   
    ip_cidr_range = var.restricted-subnet-cidr
    network = google_compute_network.main-vpc.self_link
   
    private_ip_google_access = true
   
   
    depends_on = [
        google_compute_network.main-vpc
  ]

## Create secondary ip range for pods in deployment 

    secondary_ip_range {
    range_name = "pods"
    ip_cidr_range = var.pods-cidr
  }
  
}

############# Firewall rules for Restricted Subnet ####################

## These rules are specified to block egress traffic and allow it only through google APIs



# The first rule blocks all egress traffic from restricted subnet and allows only tcp traffic on port 443 that's used to communicate with google APIs
resource "google_compute_firewall" "block_internet_egress" {
  name = "block-internet-egress"
  network = google_compute_network.main-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = [var.restricted-subnet-cidr]
  target_tags   = ["private-rules"]
  direction     = "EGRESS"

  depends_on = [
    google_compute_subnetwork.restricted-subnet,
  ]
}




## The Secod rule define destnation ranges of google APIs to allow traffic
resource "google_compute_firewall" "allow_google_apis_egress" {
  name = "allow-google-apis-egress"
  network = google_compute_network.main-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = [var.restricted-subnet-cidr]
  target_tags   = ["private-rules"]
  direction     = "EGRESS"

  destination_ranges = [
    "*.googleusercontent.com",
    "*.googleapis.com",
  ]

  depends_on = [
    google_compute_subnetwork.restricted-subnet,
  ]
}









############## NAT gateway ###############
resource "google_compute_router" "router" {
  name    = "my-router"
  network = google_compute_network.main-vpc.self_link
  region  = google_compute_subnetwork.management-subnet.region
  
}

resource "google_compute_router_nat" "nat-gateway" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.management-subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}