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
    module.network.private_subnets_ids[1]
  ]
  environment = "PRODUCTION"

  # Kafka Version and Configuration
  kafka_version = "2.8"
  brokers_count = 3
  zones = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-d"
  ]
  assign_public_ip = false
  schema_registry  = true

  # Kafka Resources
  kafka_resources_preset_id         = "s2.micro"
  kafka_disk_size                   = 100
  kafka_disk_type_id                = "network-hdd"
  kafka_compression_type            = "gzip"
  kafka_log_flush_interval_messages = 1000

  # ZooKeeper Resources
  zookeeper_resources_preset_id = "s2.micro"
  zookeeper_disk_size           = 100
  zookeeper_disk_type_id        = "network-hdd"

  # Access and Security
  data_transfer_access = true
  deletion_protection  = true

  # Maintenance Window
  maintenance_window_type = "WEEKLY"
  maintenance_window_day  = "MON"
  maintenance_window_hour = 3


  depends_on = [module.iam_accounts, module.network]
}
