resource "google_compute_network" "prod_live_vpc" {
  name = "prod-live-vpc"
  routing_mode = "REGIONAL"
  auto_create_subnetworks = false
  project = var.project_id
}

## Subnetworks

resource "google_compute_subnetwork" "prod_live_vpc_subnet" {
  name          = "prod-live-vpc-subnet"
  ip_cidr_range = var.prod_live_vpc_subnet_range
  region        = var.region_prod
  network       = google_compute_network.prod_live_vpc.name
  log_config {
    aggregation_interval = "INTERVAL_1_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
  project = var.project_id
}

