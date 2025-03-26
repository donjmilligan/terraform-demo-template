
resource "google_compute_router" "prod_live_internet_router" {
  encrypted_interconnect_router = "false"
  name                          = "prod-live-internet-router"
  network                       = google_compute_network.prod_live_vpc.id
  project                       = var.project_id
  region                        = var.region_prod
}

resource "google_compute_router_nat" "prod_live_internet_router_nat" {
  name                               = "prod-live-internet-router-nat"
  router                             = google_compute_router.prod_live_internet_router.name
  region                             = google_compute_router.prod_live_internet_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
  project = var.project_id
}
