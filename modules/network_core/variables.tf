variable "project_id" {
  description = "Google Project ID that you want the resources deployed into"
  type        = string
}

variable "region_prod" {
  description = "Region for site1-prod"
  type        = string
}

## prod
variable "prod_live_vpc_subnet_range" {
  description = "IP range for prod-live-vpc-subnet"
  type        = string
}

##########
# VM IPs
##########

####### PROD IPs

########### demo

variable "prod_demo_instance_1_live_ip" {
  description = "prod live subnetwork IP of prod-demo-instance-1"
  type        = string
}

variable "prod_demo_instance_2_live_ip" {
  description = "prod live subnetwork IP of prod-demo-instance-2"
  type        = string
}


