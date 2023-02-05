########## Networks Module ########

module "Network" {
    
    source = "./Netwrok_Infrastructure"
    management-subnet-cidr =  var.management-subnet-cidr
    restricted-subnet-cidr = var.restricted-subnet-cidr
    pods-cidr = var.pods-cidr
    region = var.region
    

}


module "VMs-NAT" {

    source = "./VMs-NAT"
    managment-subnet-link = module.Network.managment-subnet-link
  
}