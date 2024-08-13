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

  security_group_ids = var.security_group_ids
  host_group_ids     = var.host_group_ids
  deletion_protection = var.deletion_protection

  maintenance_window {
    type = var.maintenance_window_type
    day  = var.maintenance_window_day
    hour = var.maintenance_window_hour
  }
}

resource "yandex_mdb_kafka_topic" "kafka_topic" {
  cluster_id         = yandex_mdb_kafka_cluster.kafka_cluster.id
  name               = var.topic_name
  partitions         = var.topic_partitions
  replication_factor = var.topic_replication_factor

  topic_config {
    cleanup_policy        = var.topic_cleanup_policy
    compression_type      = var.topic_compression_type
    delete_retention_ms   = var.topic_delete_retention_ms
    file_delete_delay_ms  = var.topic_file_delete_delay_ms
    flush_messages        = var.topic_flush_messages
    flush_ms              = var.topic_flush_ms
    min_compaction_lag_ms = var.topic_min_compaction_lag_ms
    retention_bytes       = var.topic_retention_bytes
    retention_ms          = var.topic_retention_ms
    max_message_bytes     = var.topic_max_message_bytes
    min_insync_replicas   = var.topic_min_insync_replicas
    segment_bytes         = var.topic_segment_bytes
    preallocate           = var.topic_preallocate
  }

  depends_on = [yandex_mdb_kafka_cluster.kafka_cluster]
}

resource "yandex_mdb_kafka_user" "kafka_user" {
  cluster_id = yandex_mdb_kafka_cluster.kafka_cluster.id
  name       = var.user_name
  password   = var.user_password

  permission {
    topic_name  = var.user_permission_topic_name
    role        = var.user_permission_role
    allow_hosts = var.user_permission_allow_hosts
  }

  depends_on = [yandex_mdb_kafka_cluster.kafka_cluster]
}
