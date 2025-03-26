provider "google" {
  project         = var.project_id
  billing_project = var.billing_id
  region          = var.region_prod
  zone            = var.zone_primary_prod
}
