########## Compute IP Addresses

### prod demo

resource "google_compute_address" "prod_demo_instance_1_live_ip" {
  name         = "prod-demo-instance-1-live-ip"
  subnetwork   = google_compute_subnetwork.prod_live_vpc_subnet.id
  address_type = "INTERNAL"
  address      = var.prod_demo_instance_1_live_ip
  project      = var.project_id
  region       = var.region_prod
}

resource "google_compute_address" "prod_demo_instance_2_live_ip" {
  name         = "prod-demo-instance-2-live-ip"
  subnetwork   = google_compute_subnetwork.prod_live_vpc_subnet.id
  address_type = "INTERNAL"
  address      = var.prod_demo_instance_2_live_ip
  project      = var.project_id
  region       = var.region_prod
}







