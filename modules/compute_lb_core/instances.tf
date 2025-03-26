# VMs

resource "google_compute_instance" "demo_instances" {
  for_each = var.demo_instances
  attached_disk {
    device_name = "persistent-disk-1"
    mode        = "READ_WRITE"
    source      = each.value.attached_disk
  }

  boot_disk {
    auto_delete = "false"
    device_name = "persistent-disk-0"
    mode        = "READ_WRITE"
    source      = each.value.boot_disk
  }

  can_ip_forward      = "false"
  deletion_protection = var.vm_deletion_protection
  enable_display      = "false"
  machine_type        = var.linux_instance_type

  metadata = {
    block-project-ssh-keys   = "TRUE"
    enable-oslogin           = "TRUE"
    google-logging-enable    = "1"
    google-monitoring-enable = "1"
    serial-port-enable       = "FALSE"
  }

  name = each.key

  network_interface {
    network_ip         = each.value.network_ip1
    queue_count        = "0"
    stack_type         = "IPV4_ONLY"
    subnetwork         = each.value.subnetwork1
    subnetwork_project = var.project_id
  }

  project = var.project_id
  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = "true"
    min_node_cpus       = "0"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = var.module_iam.demo_service_account
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/pubsub", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "true"
    enable_vtpm                 = "true"
  }

  tags = each.value.tags
  zone = each.value.zone

  depends_on = [
    google_compute_disk.boot_disks,
    google_compute_disk.attatched_disks
  ]
}
