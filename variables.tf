variable "project_id" {
  description = "Google Project ID that you want the resources deployed into"
  type        = string
  default     = null
}

variable "billing_id" {
  description = "Billing account ID"
  type        = string
  default     = null
}

variable "region_prod" {
  description = "Region for site1-prod"
  type        = string
  default     = "us-central1"
}

variable "zone_primary_prod" {
  description = "Default zone for site1-prod"
  type        = string
  default     = "us-central1-a"
}

variable "resource_name_suffix" {
  default     = null
  description = "A suffix which will be appended to resource names."
  type        = string
}


#--------------------#
#        APIs
#--------------------#

variable "apis" {
  description = "APIs to enable for projects"
  type        = list(string)
  default = [
    "admin.googleapis.com",
    "binaryauthorization.googleapis.com",
    "cloudasset.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "dns.googleapis.com",
    "essentialcontacts.googleapis.com",
    "iam.googleapis.com",
    "iap.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "osconfig.googleapis.com",
    "servicemanagement.googleapis.com",
    "serviceusage.googleapis.com",
    "sqladmin.googleapis.com"
  ]
}

#--------------------#
#     Networks
#--------------------#

############
# VPCs
############




############
# IPs
############

## prod subnet CIDRs
variable "prod_live_vpc_subnet_range" {
  description = "IP range for prod-live-vpc-subnet"
  type        = string
  default     = "10.200.0.0/25"
}

############      VM IPs

### demo Prod

variable "prod_demo_instance_1_live_ip" {
  description = "prod live subnetwork IP of prod-demo-instance-1"
  type        = string
  default     = "10.200.0.11"
}

variable "prod_demo_instance_2_live_ip" {
  description = "prod live subnetwork IP of prod-demo-instance-2"
  type        = string
  default     = "10.200.0.12"
}

#--------------------#
# Compute Engine VMs
#--------------------#

########### DISKS

variable "boot_disk_image" {
  # NOTE This value should not be changed for Prod since these machines were built with this image.
  description = "The version of the boot disk image used on OTAP and demo VMs"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
  # need to find the latest valid cis image for dev or lab?
  # gcloud compute images list --project cis-public
}

variable "boot_disk_size" {
  description = "size in GB of the boot disk"
  type        = string
  default     = "20"
}

variable "attatched_disk_size" {
  description = "size in GB of the attatched disk"
  type        = string
  default     = "10"
}

variable "boot_disks" {
  description = "Map of objects containing boot disk references"
  type = map(object({
    zone            = string
    sn_policy_name  = string
  }))

  default = {
    prod-demo-instance-1-boot = {
      zone            = "us-central1-a"
      sn_policy_name  = "usc1-daily-one-week"
    }
    prod-demo-instance-2-boot = {
      zone            = "us-central1-a"
      sn_policy_name  = "usc1-daily-one-week"
    }
  }
}

variable "attatched_disks" {
  description = "Map of objects containing references to attatched disks to build"
  type = map(object({
    zone            = string
    sn_policy_name  = string
  }))

  default = {
    prod-demo-instance-1-attatched = {
      zone            = "us-central1-a"
      sn_policy_name  = "usc1-weekly-one-month"
    }
    prod-demo-instance-2-attatched = {
      zone            = "us-central1-a"
      sn_policy_name  = "usc1-weekly-one-month"
    }
  }
}


########### other

variable "linux_instance_type" {
  description = "GCP machine type for VM"
  type        = string
  default     = "e2-standard-8"
}

variable "vm_deletion_protection" {
  type          = bool
  description   = "Boolean true or falce for vm deletion protection"
  default       = true
}

# demo

variable "demo_instances" {
  description = "Map of objects containing demo VM instance references"
  type = map(object({
    attached_disk   = string
    boot_disk       = string
    network_ip1     = string
    subnetwork1     = string
    tags            = list(string)
    zone            = string
  }))

  default = {
    site1-prod-demo1 = {
      attached_disk   = "prod-demo-instance-1-attatched"
      boot_disk       = "prod-demo-instance-1-boot"
      network_ip1     = "10.200.0.11"
      subnetwork1     = "prod-live-vpc-subnet"
      tags            = ["prod-demo"]
      zone            = "us-central1-a"
    }
    site1-prod-demo2 = {
      attached_disk   = "prod-demo-instance-2-attatched"
      boot_disk       = "prod-demo-instance-2-boot"
      network_ip1     = "10.200.0.12"
      subnetwork1     = "prod-live-vpc-subnet"
      tags            = ["prod-demo"]
      zone            = "us-central1-a"
    }
  }
}
