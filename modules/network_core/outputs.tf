output "prod_live_vpc" {
  description = "ID of Prod live VPC"
  value       = google_compute_network.prod_live_vpc.id
}

### live
output "prod_live_vpc_subnet" {
  description = "Name of prod_live_vpc_subnet"
  value       = google_compute_subnetwork.prod_live_vpc_subnet.name
}

###########################
# Compute IP Addresss
###########################

################ PROD

### prod demo

output "prod_demo_instance_1_live_ip" {
  description = "IP Address prod_demo_instance_1_live_ip"
  value       = google_compute_address.prod_demo_instance_1_live_ip.address
}

output "prod_demo_instance_2_live_ip" {
  description = "IP Address prod_demo_instance_2_live_ip"
  value       = google_compute_address.prod_demo_instance_2_live_ip.address
}

