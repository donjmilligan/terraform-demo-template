# Service Accounts
resource "google_service_account" "demo_sa" {
  account_id   = var.demo_sa
  description  = "Used on demo machines only"
  disabled     = "false"
  display_name = var.demo_sa
  project      = var.project_id
}

# SA Permissions

resource "google_project_iam_member" "logging_log_writer" {
  for_each = toset([
    "serviceAccount:${var.demo_sa}@${var.project_id}.iam.gserviceaccount.com",
  ])
  project = var.project_id
  member  = each.key
  role    = "roles/logging.logWriter"
  depends_on = [google_service_account.demo_sa,]

}

resource "google_project_iam_member" "monitoring_metric_writer" {
  for_each = toset([
    "serviceAccount:${var.demo_sa}@${var.project_id}.iam.gserviceaccount.com",
  ])
  project = var.project_id
  member  = each.key
  role    = "roles/monitoring.metricWriter"
  depends_on = [google_service_account.demo_sa,]

}

