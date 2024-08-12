resource "yandex_mdb_kafka_cluster" "kafka_cluster" {
  name        = var.cluster_name
  description = var.cluster_description
  folder_id   = var.folder_id
  labels      = var.labels
  network_id  = var.network_id
  subnet_ids  = var.subnet_ids
  environment = var.environment

  config {
    version          = var.kafka_version
    brokers_count    = var.brokers_count
    zones            = var.zones
    assign_public_ip = var.assign_public_ip
    schema_registry  = var.schema_registry

    kafka {
      resources {
        resources_preset_id = var.kafka_resources_preset_id
        disk_size           = var.kafka_disk_size
        disk_type_id        = var.kafka_disk_type_id
      }

      kafka_config {
        compression_type            = var.kafka_compression_type
        log_flush_interval_messages = var.kafka_log_flush_interval_messages
      }
    }

    zookeeper {
      resources {
        resources_preset_id = var.zookeeper_resources_preset_id
        disk_size           = var.zookeeper_disk_size
        disk_type_id        = var.zookeeper_disk_type_id
      }
    }

    access {
      data_transfer = var.data_transfer_access
    }
  }

  security_group_ids = var.security_group_ids
  host_group_ids     = var.host_group_ids
  deletion_protection = var.deletion_protection

  maintenance_window {
    type = var.maintenance_window_type
    day  = var.maintenance_window_day
    hour = var.maintenance_window_hour
  }
}
