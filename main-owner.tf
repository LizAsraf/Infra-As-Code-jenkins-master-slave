module "network" {
  source                 = "./modules/network"
  public_subnets_per_vpc = var.public_subnets_per_vpc
  enviroment             = var.enviroment
}

module "security" {
  source = "./modules/security"
  depends_on = [module.network]
  vpcid      = module.network.vpcid
  enviroment = var.enviroment
  vpcname    = module.network.vpcname
}

module "compute" {
  source = "./modules/compute"
  depends_on = [module.security]
  security_groups = module.security.security_groups
  subnet = module.network.subnet
  enviroment = var.enviroment
  instances_per_subnet = var.instances_per_subnet
  ami-slave = var.ami-slave
  ami-master = var.ami-master
  aws_iam_instance_profile = module.security.profile_name
  public_subnets_per_vpc = var.public_subnets_per_vpc
}