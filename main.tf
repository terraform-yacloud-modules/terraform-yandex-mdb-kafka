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
        resource_preset_id = var.kafka_resource_preset_id
        disk_size          = var.kafka_disk_size
        disk_type_id       = var.kafka_disk_type_id
      }

      kafka_config {
        compression_type            = var.kafka_compression_type
        log_flush_interval_messages = var.kafka_log_flush_interval_messages
      }
    }

    zookeeper {
      resources {
        resource_preset_id = var.zookeeper_resource_preset_id
        disk_size          = var.zookeeper_disk_size
        disk_type_id       = var.zookeeper_disk_type_id
      }
    }

    access {
      data_transfer = var.data_transfer_access
    }
  }

  security_group_ids  = var.security_group_ids
  host_group_ids      = var.host_group_ids
  deletion_protection = var.deletion_protection

  maintenance_window {
    type = var.maintenance_window_type
    day  = var.maintenance_window_day
    hour = var.maintenance_window_hour
  }
}

resource "yandex_mdb_kafka_topic" "kafka_topic" {
  for_each = { for idx, topic in var.topics : idx => topic }

  cluster_id         = yandex_mdb_kafka_cluster.kafka_cluster.id
  name               = each.value.name
  partitions         = each.value.partitions
  replication_factor = each.value.replication_factor

  topic_config {
    cleanup_policy        = each.value.config.cleanup_policy
    compression_type      = each.value.config.compression_type
    delete_retention_ms   = each.value.config.delete_retention_ms
    file_delete_delay_ms  = each.value.config.file_delete_delay_ms
    flush_messages        = each.value.config.flush_messages
    flush_ms              = each.value.config.flush_ms
    min_compaction_lag_ms = each.value.config.min_compaction_lag_ms
    retention_bytes       = each.value.config.retention_bytes
    retention_ms          = each.value.config.retention_ms
    max_message_bytes     = each.value.config.max_message_bytes
    min_insync_replicas   = each.value.config.min_insync_replicas
    segment_bytes         = each.value.config.segment_bytes
    preallocate           = each.value.config.preallocate
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  depends_on = [yandex_mdb_kafka_cluster.kafka_cluster]
}

resource "yandex_mdb_kafka_user" "kafka_user" {
  for_each = { for idx, user in var.users : idx => user }

  cluster_id = yandex_mdb_kafka_cluster.kafka_cluster.id
  name       = each.value.name
  password   = each.value.password

  dynamic "permission" {
    for_each = each.value.permissions
    content {
      topic_name  = permission.value.topic_name
      role        = permission.value.role
      allow_hosts = permission.value.allow_hosts
    }
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  depends_on = [yandex_mdb_kafka_topic.kafka_topic]
}
