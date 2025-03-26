## Boot

# note that creation of these boot_disks will fail if an older versoin than the most recent cis image is listed here. Get the new one.
resource "google_compute_disk" "boot_disks" {
  for_each = var.boot_disks
  image                     = var.boot_disk_image
  name                      = each.key
  physical_block_size_bytes = "4096"
  project                   = var.project_id
  provisioned_iops          = "0"
  size                      = var.boot_disk_size
  type                      = "pd-ssd"
  zone                      = each.value.zone
}

# Attatched

resource "google_compute_disk" "attatched_disks" {
  for_each = var.attatched_disks

  name                      = each.key
  physical_block_size_bytes = "4096"
  project                   = var.project_id
  provisioned_iops          = "0"
  size                      = var.attatched_disk_size
  type                      = "pd-balanced"
  zone                      = each.value.zone
  depends_on = [
    google_compute_resource_policy.usc1_weekly_one_month
  ]
}

# Disk Snapshot Schedules

resource "google_compute_resource_policy" "usc1_weekly_one_month" {

  name    = "usc1-weekly-one-month"
  project = var.project_id
  region  = var.region_prod

  snapshot_schedule_policy {
    retention_policy {
      max_retention_days    = "30"
      on_source_disk_delete = "APPLY_RETENTION_POLICY"
    }

    schedule {
      weekly_schedule {
        day_of_weeks {
          day        = "SUNDAY"
          start_time = "01:00"
        }
      }
    }

    snapshot_properties {
      guest_flush       = "false"
      storage_locations = [var.region_prod]
    }
  }
}

resource "google_compute_resource_policy" "usc1_daily_one_week" {
  description = "daily north america northeast1 snapshots"
  name    = "usc1-daily-one-week"
  project = var.project_id
  region  = var.region_prod

  snapshot_schedule_policy {
    retention_policy {
      max_retention_days    = "7"
      on_source_disk_delete = "APPLY_RETENTION_POLICY"
    }

    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "04:00"
      }
    }

    snapshot_properties {
      guest_flush       = "false"
      storage_locations = [var.region_prod]
    }
  }
}

# Link Disks & Schedules

resource "google_compute_disk_resource_policy_attachment" "boot_disks" {
  for_each = var.boot_disks
  name = each.value.sn_policy_name
  disk = each.key
  project = var.project_id
  zone = each.value.zone
  depends_on = [
    google_compute_disk.attatched_disks
  ]
}

resource "google_compute_disk_resource_policy_attachment" "attatched_disks" {
  for_each = var.attatched_disks
  name = each.value.sn_policy_name
  disk = each.key
  project = var.project_id
  zone = each.value.zone
  depends_on = [
    google_compute_disk.attatched_disks
  ]
}
