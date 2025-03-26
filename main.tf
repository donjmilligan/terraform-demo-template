terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.59.0"
    }
  }
}

#--------#
# Locals #
#--------#

locals {
  random_hash = var.resource_name_suffix == null ? random_id.random_hash_suffix.hex : var.resource_name_suffix
}

#-----------#
# Resources #
#-----------#

resource "random_id" "random_hash_suffix" {
  byte_length = 4
}

resource "google_project_service" "apis" {
  for_each                   = toset(var.apis)
  disable_dependent_services = false
  disable_on_destroy         = false
  project                    = var.project_id
  service                    = each.key
}

resource "google_storage_bucket" "demo_bucket" {
  name     =  "dons-cloud-demo-bucket-${local.random_hash}"
  location = "US"
}

#---------#
# Modules #
#---------#

module "iam" {
  source = "./modules/iam"

  project_id = var.project_id
}

module "network_core" {
  source = "./modules/network_core"

  prod_demo_instance_1_live_ip              = var.prod_demo_instance_1_live_ip
  prod_demo_instance_2_live_ip              = var.prod_demo_instance_2_live_ip
  prod_live_vpc_subnet_range                = var.prod_live_vpc_subnet_range
  project_id                                 = var.project_id
  region_prod                                = var.region_prod
}

module "compute_lb_core" {
  source              = "./modules/compute_lb_core"
  module_iam          = module.iam
  module_network_core = module.network_core

  attatched_disk_size              = var.attatched_disk_size
  attatched_disks                  = var.attatched_disks
  boot_disk_image                  = var.boot_disk_image
  boot_disk_size                   = var.boot_disk_size
  boot_disks                       = var.boot_disks
  demo_instances                   = var.demo_instances
  linux_instance_type              = var.linux_instance_type
  project_id                       = var.project_id
  region_prod                      = var.region_prod
  vm_deletion_protection           = var.vm_deletion_protection
  zone_primary_prod                = var.zone_primary_prod
}

