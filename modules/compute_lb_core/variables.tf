variable "project_id" {
  description = "Google Project ID that you want the resources deployed into"
  type        = string
}

variable "region_prod" {
  description = "Region for site1-prod"
  type        = string
}

variable "zone_primary_prod" {
  description = "Default zone for site1-prod"
  type        = string
}


########### other
variable "linux_instance_type" {
  description = "GCP machine type for VM"
  type        = string
}

variable "boot_disk_size" {
  description = "size in GB of the boot disk"
  type        = string
}

variable "attatched_disk_size" {
  description = "size in GB of the attatched disk"
  type        = string
}

variable "vm_deletion_protection" {
  type          = bool
  description   = "Boolean true or falce for vm deletion protection"
}

#--------------------#
#   Module IAM #
#--------------------#

# NOTE: leave the tflint ignore lines, as they allow us to not declare a type and still pass tflint checks

# tflint-ignore: terraform_typed_variables
variable "module_iam" {
  description = "The IAM module"
}

#--------------------#
# Module Network Core
#--------------------#

# tflint-ignore: terraform_typed_variables
variable "module_network_core" {
  description = "The Network Core module"
}


#--------------------#
# Compute Engine VMs
#--------------------#

variable "boot_disk_image" {
  # NOTE Changing this vaule in Prod will result in rebuilt VMs
  description = "The version of the boot disk image used on demo VMs"
  type        = string
}

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
}

#----------------------#
# Compute Engine Disks
#----------------------#

variable "boot_disks" {
  description = "Map of objects containing boot disk references"
  type = map(object({
    zone            = string
    sn_policy_name  = string
  }))
}

variable "attatched_disks" {
  description = "Map of objects containing attatched references"
  type = map(object({
    zone            = string
    sn_policy_name  = string
  }))
}
