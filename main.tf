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
        compression_type                = var.kafka_compression_type
        log_flush_interval_messages     = var.kafka_log_flush_interval_messages
        log_flush_interval_ms           = var.kafka_log_flush_interval_ms
        log_flush_scheduler_interval_ms = var.kafka_log_flush_scheduler_interval_ms
        log_retention_bytes             = var.kafka_log_retention_bytes
        log_retention_hours             = var.kafka_log_retention_hours
        log_retention_minutes           = var.kafka_log_retention_minutes
        log_retention_ms                = var.kafka_log_retention_ms
        log_segment_bytes               = var.kafka_log_segment_bytes
        num_partitions                  = var.kafka_num_partitions
        default_replication_factor      = var.kafka_default_replication_factor
        message_max_bytes               = var.kafka_message_max_bytes
        replica_fetch_max_bytes         = var.kafka_replica_fetch_max_bytes
        ssl_cipher_suites               = var.kafka_ssl_cipher_suites
        offsets_retention_minutes       = var.kafka_offsets_retention_minutes
        sasl_enabled_mechanisms         = var.kafka_sasl_enabled_mechanisms
      }
    }

    zookeeper {
      resources {
        resource_preset_id = var.zookeeper_resource_preset_id
        disk_size          = var.zookeeper_disk_size
        disk_type_id       = var.zookeeper_disk_type_id
      }
    }

    dynamic "kraft" {
      for_each = var.kraft_resource_preset_id != null || var.kraft_disk_size != null || var.kraft_disk_type_id != null ? [1] : []
      content {
        resources {
          resource_preset_id = var.kraft_resource_preset_id
          disk_size          = var.kraft_disk_size
          disk_type_id       = var.kraft_disk_type_id
        }
      }
    }

    rest_api {
      enabled = var.rest_api_enabled
    }

    kafka_ui {
      enabled = var.kafka_ui_enabled
    }

    dynamic "disk_size_autoscaling" {
      for_each = var.disk_size_autoscaling == null ? [] : [var.disk_size_autoscaling]
      content {
        disk_size_limit           = disk_size_autoscaling.value.disk_size_limit
        planned_usage_threshold   = disk_size_autoscaling.value.planned_usage_threshold
        emergency_usage_threshold = disk_size_autoscaling.value.emergency_usage_threshold
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

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = try(timeouts.value.create, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }

}

resource "yandex_mdb_kafka_topic" "kafka_topic" {
  for_each = { for idx, topic in var.topics : idx => topic }

  cluster_id         = yandex_mdb_kafka_cluster.kafka_cluster.id
  name               = each.value.name
  partitions         = each.value.partitions
  replication_factor = each.value.replication_factor

  dynamic "topic_config" {
    for_each = each.value.config == null ? [] : [each.value.config]
    content {
      cleanup_policy        = topic_config.value.cleanup_policy
      compression_type      = topic_config.value.compression_type
      delete_retention_ms   = topic_config.value.delete_retention_ms
      file_delete_delay_ms  = topic_config.value.file_delete_delay_ms
      flush_messages        = topic_config.value.flush_messages
      flush_ms              = topic_config.value.flush_ms
      min_compaction_lag_ms = topic_config.value.min_compaction_lag_ms
      retention_bytes       = topic_config.value.retention_bytes
      retention_ms          = topic_config.value.retention_ms
      max_message_bytes     = topic_config.value.max_message_bytes
      min_insync_replicas   = topic_config.value.min_insync_replicas
      segment_bytes         = topic_config.value.segment_bytes
      preallocate           = topic_config.value.preallocate
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = try(timeouts.value.create, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
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

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }

  depends_on = [yandex_mdb_kafka_topic.kafka_topic]
}
