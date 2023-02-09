########## Networks Module ########

module "Network" {

  source = "./Netwrok_Infrastructure"
  
  # Subnets
  management-subnet-cidr = var.management-subnet-cidr
  restricted-subnet-cidr = var.restricted-subnet-cidr
 
  # Pods Cidr range 
  pods-cidr = var.pods-cidr
  region    = var.region



}

############## VM and NAT gatway Module ##########
module "VMs-NAT" {

  source = "./VMs"
  # Subnet
  managment-subnet-link = module.Network.managment-subnet-link
  vpc                   = module.Network.vpc
  project               = var.project
}


########### GKE Cluster Module ###########
module "Cluster" {

  source                 = "./Cluster"
  project                = var.project
  restricted-subnet-link = module.Network.restricted-subnet-link
  vpc                    = module.Network.vpc
 
 # IPs
  master_ipv4            = var.master_ipv4
  services_ipv4          = var.services_ipv4
  cluster_ipv4           = var.cluster_ipv4

}