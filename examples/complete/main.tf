data "yandex_client_config" "client" {}

provider "yandex" {
}

locals {
  folder_id   = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)
  bucket_name = "kafka-s3-sink-${local.folder_id}"
}

module "iam_accounts" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-iam.git//modules/iam-account?ref=v1.0.0"

  name      = "kafka-example-iam"
  folder_id = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)
  folder_roles = [
    "admin",
  ]
  cloud_roles              = []
  enable_static_access_key = false
  enable_api_key           = false
  enable_account_key       = false

}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)

  blank_name = "kafka-vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-d"]

  private_subnets = [["10.3.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}

# Service account and bucket used by the Kafka S3 Sink connector example.
resource "yandex_iam_service_account" "kafka_s3_sink" {
  name      = "kafka-example-s3-sink"
  folder_id = local.folder_id
}

resource "yandex_storage_bucket" "kafka_s3_sink" {
  bucket        = local.bucket_name
  folder_id     = local.folder_id
  force_destroy = true
}

resource "yandex_storage_bucket_iam_binding" "kafka_s3_sink" {
  bucket  = yandex_storage_bucket.kafka_s3_sink.bucket
  role    = "storage.editor"
  members = ["serviceAccount:${yandex_iam_service_account.kafka_s3_sink.id}"]
}

resource "yandex_iam_service_account_static_access_key" "kafka_s3_sink" {
  service_account_id = yandex_iam_service_account.kafka_s3_sink.id
  description        = "Static key for the Kafka S3 Sink connector example"

  depends_on = [yandex_storage_bucket_iam_binding.kafka_s3_sink]
}

module "kafka" {
  source = "../../"

  # General Cluster Settings
  cluster_name        = "example-kafka-cluster"
  cluster_description = "An example Kafka cluster"
  folder_id           = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)
  labels = {
    environment = "production"
    team        = "devops"
  }
  network_id = module.network.vpc_id
  subnet_ids = [
    module.network.private_subnets_ids[0],
  ]
  environment = "PRODUCTION"

  # Kafka Version and Configuration
  kafka_version = "3.7"
  brokers_count = 3
  zones = [
    "ru-central1-d",
  ]
  assign_public_ip = false
  schema_registry  = true

  # Kafka Resources
  kafka_resource_preset_id              = "s2.micro"
  kafka_disk_size                       = 100
  kafka_disk_type_id                    = "network-ssd"
  kafka_compression_type                = "COMPRESSION_TYPE_GZIP"
  kafka_auto_create_topics_enable       = true
  kafka_log_flush_interval_messages     = 1000
  kafka_log_flush_interval_ms           = 1000
  kafka_log_flush_scheduler_interval_ms = 1000
  kafka_log_message_timestamp_type      = "MESSAGE_TIMESTAMP_TYPE_CREATE_TIME"
  kafka_log_segment_bytes               = 104857600
  kafka_log_retention_bytes             = 1073741824
  kafka_log_retention_hours             = 168
  kafka_log_retention_minutes           = 10080
  kafka_log_retention_ms                = 86400000
  kafka_replica_fetch_max_bytes         = 1048576
  kafka_ssl_cipher_suites               = ["TLS_DHE_RSA_WITH_AES_128_CBC_SHA", "TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256"]
  kafka_offsets_retention_minutes       = 10080
  kafka_num_partitions                  = 100
  kafka_default_replication_factor      = 2
  kafka_message_max_bytes               = 1048576
  kafka_sasl_enabled_mechanisms         = ["SASL_MECHANISM_SCRAM_SHA_512"]
  kafka_socket_receive_buffer_bytes     = 1048576
  kafka_socket_send_buffer_bytes        = 1048576
  kafka_transactional_id_expiration_ms  = 604800000

  # KRaft-combine quorum: controllers run on the broker hosts, so no
  # dedicated KRaft subcluster is created. A dedicated one requires
  # controller zones, which do not exist in a single-zone deployment.

  # Access and Security
  security_group_ids      = []
  host_group_ids          = []
  data_transfer_access    = true
  deletion_protection     = false
  maintenance_window_type = "WEEKLY"
  maintenance_window_day  = "SAT"
  maintenance_window_hour = 3

  # Additional Features
  rest_api_enabled = true
  kafka_ui_enabled = true

  # Disk Autoscaling
  disk_size_autoscaling = {
    disk_size_limit           = 200
    planned_usage_threshold   = 80
    emergency_usage_threshold = 90
  }

  topics = [
    {
      name               = "topic1"
      partitions         = 2
      replication_factor = 2
      config = {
        cleanup_policy         = "CLEANUP_POLICY_DELETE"
        compression_type       = "COMPRESSION_TYPE_PRODUCER"
        delete_retention_ms    = 86400000
        file_delete_delay_ms   = 60000
        flush_messages         = 9223372036854775807
        flush_ms               = 9223372036854775807
        min_compaction_lag_ms  = 0
        retention_bytes        = -1
        retention_ms           = 604800000
        max_message_bytes      = 1048588
        min_insync_replicas    = 1
        segment_bytes          = 1073741824
        message_timestamp_type = "MESSAGE_TIMESTAMP_TYPE_CREATE_TIME"
      }
    },
    {
      name               = "topic2"
      partitions         = 1
      replication_factor = 1
    },
  ]

  users = [
    {
      name     = "user1"
      password = "password1"
      permissions = [
        {
          topic_name  = "topic1"
          role        = "ACCESS_ROLE_CONSUMER"
          allow_hosts = ["*"]
        },
        {
          topic_name  = "topic2"
          role        = "ACCESS_ROLE_PRODUCER"
          allow_hosts = ["*"]
        }
      ]
    },
    {
      name     = "user2"
      password = "password2"
      permissions = [
        {
          topic_name  = "topic1"
          role        = "ACCESS_ROLE_PRODUCER"
          allow_hosts = ["*"]
        },
        {
          topic_name  = "topic2"
          role        = "ACCESS_ROLE_CONSUMER"
          allow_hosts = ["*"]
        }
      ]
    }
  ]

  # Kafka connectors
  connectors = [
    {
      name      = "s3-sink"
      tasks_max = 1
      properties = {
        "key.converter"                  = "org.apache.kafka.connect.storage.StringConverter"
        "value.converter"                = "org.apache.kafka.connect.json.JsonConverter"
        "value.converter.schemas.enable" = "false"
        "format.output.type"             = "jsonl"
        "file.name.template"             = "{{topic}}-{{partition:padding=true}}-{{start_offset:padding=true}}.gz"
        "timestamp.timezone"             = "Europe/Moscow"
      }
      s3_sink = {
        topics                = "topic1"
        file_compression_type = "gzip"
        file_max_records      = 100
        s3_connection = {
          bucket_name = yandex_storage_bucket.kafka_s3_sink.bucket
          external_s3 = {
            endpoint          = "storage.yandexcloud.net"
            access_key_id     = yandex_iam_service_account_static_access_key.kafka_s3_sink.access_key
            secret_access_key = yandex_iam_service_account_static_access_key.kafka_s3_sink.secret_key
          }
        }
      }
    },
  ]

  depends_on = [module.iam_accounts, module.network]

  timeouts = {
    create = "40m"
    update = "40m"
    delete = "40m"
  }

}
