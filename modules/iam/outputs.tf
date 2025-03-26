output "demo_service_account" {
  description = "Service account for demo VMs"
  value       = google_service_account.demo_sa.email
}