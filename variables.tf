variable "cluster_name" {
  description = "Name of the Kafka cluster"
  type        = string
}

variable "cluster_description" {
  description = "Description of the Kafka cluster"
  type        = string
  default     = ""
}

variable "folder_id" {
  description = "The ID of the folder that the resource belongs to"
  type        = string
  default     = null
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the Kafka cluster"
  type        = map(string)
  default     = {}
}

variable "network_id" {
  description = "ID of the network, to which the Kafka cluster belongs"
  type        = string
}

variable "subnet_ids" {
  description = "IDs of the subnets, to which the Kafka cluster belongs"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "Deployment environment of the Kafka cluster"
  type        = string
  default     = "PRODUCTION"
}

variable "kafka_version" {
  description = "Version of the Kafka server software"
  type        = string
}

variable "brokers_count" {
  description = "Count of brokers per availability zone"
  type        = number
  default     = 1
}

variable "zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Determines whether each broker will be assigned a public IP address"
  type        = bool
  default     = false
}

variable "schema_registry" {
  description = "Enables managed schema registry on cluster"
  type        = bool
  default     = false
}

variable "kafka_resource_preset_id" {
  description = "The ID of the preset for computational resources available to a Kafka host"
  type        = string
}

variable "kafka_disk_size" {
  description = "Volume of the storage available to a Kafka host, in gigabytes"
  type        = number
}

variable "kafka_disk_type_id" {
  description = "Type of the storage of Kafka hosts"
  type        = string
}

variable "kafka_compression_type" {
  description = "Kafka server compression type"
  type        = string
  default     = null
}

variable "kafka_log_flush_interval_messages" {
  description = "Kafka server log flush interval messages"
  type        = number
  default     = null
}

variable "zookeeper_resource_preset_id" {
  description = "The ID of the preset for computational resources available to a ZooKeeper host"
  type        = string
}

variable "zookeeper_disk_size" {
  description = "Volume of the storage available to a ZooKeeper host, in gigabytes"
  type        = number
}

variable "zookeeper_disk_type_id" {
  description = "Type of the storage of ZooKeeper hosts"
  type        = string
}

variable "data_transfer_access" {
  description = "Allow access for DataTransfer"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "Security group ids, to which the Kafka cluster belongs"
  type        = list(string)
  default     = []
}

variable "host_group_ids" {
  description = "A list of IDs of the host groups to place VMs of the cluster on"
  type        = list(string)
  default     = []
}

variable "deletion_protection" {
  description = "Inhibits deletion of the cluster"
  type        = bool
  default     = false
}

variable "maintenance_window_type" {
  description = "Type of maintenance window"
  type        = string
}

variable "maintenance_window_day" {
  description = "Day of the week for maintenance window"
  type        = string
  default     = null
}

variable "maintenance_window_hour" {
  description = "Hour of the day in UTC for maintenance window"
  type        = number
  default     = null
}

variable "topic_name" {
  description = "The name of the topic"
  type        = string
}

variable "topic_partitions" {
  description = "The number of the topic's partitions"
  type        = number
}

variable "topic_replication_factor" {
  description = "Amount of data copies (replicas) for the topic in the cluster"
  type        = number
}

variable "topic_cleanup_policy" {
  description = "Kafka topic cleanup policy"
  type        = string
  default     = null
}

variable "topic_compression_type" {
  description = "Kafka topic compression type"
  type        = string
  default     = null
}

variable "topic_delete_retention_ms" {
  description = "Kafka topic delete retention milliseconds"
  type        = number
  default     = null
}

variable "topic_file_delete_delay_ms" {
  description = "Kafka topic file delete delay milliseconds"
  type        = number
  default     = null
}

variable "topic_flush_messages" {
  description = "Kafka topic flush messages"
  type        = number
  default     = null
}

variable "topic_flush_ms" {
  description = "Kafka topic flush milliseconds"
  type        = number
  default     = null
}

variable "topic_min_compaction_lag_ms" {
  description = "Kafka topic min compaction lag milliseconds"
  type        = number
  default     = null
}

variable "topic_retention_bytes" {
  description = "Kafka topic retention bytes"
  type        = number
  default     = null
}

variable "topic_retention_ms" {
  description = "Kafka topic retention milliseconds"
  type        = number
  default     = null
}

variable "topic_max_message_bytes" {
  description = "Kafka topic max message bytes"
  type        = number
  default     = null
}

variable "topic_min_insync_replicas" {
  description = "Kafka topic min insync replicas"
  type        = number
  default     = null
}

variable "topic_segment_bytes" {
  description = "Kafka topic segment bytes"
  type        = number
  default     = null
}

variable "topic_preallocate" {
  description = "Kafka topic preallocate"
  type        = bool
  default     = false
}

variable "user_name" {
  description = "The name of the user"
  type        = string
}

variable "user_password" {
  description = "The password of the user"
  type        = string
}

variable "user_permission_topic_name" {
  description = "The name of the topic that the permission grants access to"
  type        = string
}

variable "user_permission_role" {
  description = "The role type to grant to the topic"
  type        = string
}

variable "user_permission_allow_hosts" {
  description = "Set of hosts, to which this permission grants access to"
  type        = list(string)
  default     = []
}
