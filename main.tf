provider "aws" {
  region = var.region
}

module "networking" {
  source            = "./modules/networking"
  vpc_cidr          = var.vpc_cidr
  public_cidr       = var.public_cidr
  private_cidr      = var.private_cidr
  availability_zone = var.availability_zone
}

module "ssh_key" {
  source = "./modules/ssh_key"
}

module "ec2" {
  source            = "./modules/ec2"
  vpc_id            = module.networking.vpc_id
  public_subnet_id  = module.networking.public_subnet_id
  private_subnet_id = module.networking.private_subnet_id
  key_name          = module.ssh_key.key_name
}
