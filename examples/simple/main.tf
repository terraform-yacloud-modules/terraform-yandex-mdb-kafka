data "yandex_client_config" "client" {}

module "iam_accounts" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-iam.git//modules/iam-account?ref=v1.0.0"

  name = "iam"
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

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "kafka-vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]

  private_subnets = [["10.3.0.0/24"], ["10.4.0.0/24"], ["10.5.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}


module "kafka" {
  source = "../../"

  # General Cluster Settings
  cluster_name        = "example-kafka-cluster"
  cluster_description = "An example Kafka cluster"
  folder_id           = data.yandex_client_config.client.folder_id
  labels = {
    environment = "production"
    team        = "devops"
  }
  network_id = module.network.vpc_id
  subnet_ids = [
    module.network.private_subnets_ids[0],
    module.network.private_subnets_ids[1],
    module.network.private_subnets_ids[2]
  ]
  environment = "PRODUCTION"

  # Kafka Version and Configuration
  kafka_version = "3.4"
  brokers_count = 3
  zones = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-d"
  ]
  assign_public_ip = false
  schema_registry  = true

  # Kafka Resources
  kafka_resource_preset_id          = "s2.micro"
  kafka_disk_size                   = 100
  kafka_disk_type_id                = "network-ssd"
  kafka_compression_type            = "COMPRESSION_TYPE_GZIP"
  kafka_log_flush_interval_messages = 1000

  # ZooKeeper Resources
  zookeeper_resource_preset_id = "s2.micro"
  zookeeper_disk_size          = 100
  zookeeper_disk_type_id       = "network-ssd"

  # Access and Security
  data_transfer_access    = true
  deletion_protection     = false
  maintenance_window_type = "ANYTIME"

  topics = [
    {
      name               = "topic1"
      partitions         = 2
      replication_factor = 2
      config = {
        cleanup_policy        = "CLEANUP_POLICY_DELETE"
        compression_type      = "COMPRESSION_TYPE_PRODUCER"
        delete_retention_ms   = 86400000
        file_delete_delay_ms  = 60000
        flush_messages        = 9223372036854775807
        flush_ms              = 9223372036854775807
        min_compaction_lag_ms = 0
        retention_bytes       = -1
        retention_ms          = 604800000
        max_message_bytes     = 1048588
        min_insync_replicas   = 1
        segment_bytes         = 1073741824
        preallocate           = false
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

  depends_on = [module.iam_accounts, module.network]
}
