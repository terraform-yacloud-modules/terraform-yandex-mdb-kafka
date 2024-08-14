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

variable "topics" {
  description = "List of Kafka topics to create"
  type = list(object({
    name               = string
    partitions         = number
    replication_factor = number
    config = object({
      cleanup_policy        = string
      compression_type      = string
      delete_retention_ms   = number
      file_delete_delay_ms  = number
      flush_messages        = number
      flush_ms              = number
      min_compaction_lag_ms = number
      retention_bytes       = number
      retention_ms          = number
      max_message_bytes     = number
      min_insync_replicas   = number
      segment_bytes         = number
      preallocate           = bool
    })
  }))
  default = []
}

variable "users" {
  description = "List of Kafka users to create"
  type = list(object({
    name     = string
    password = string
    permissions = list(object({
      topic_name  = string
      role        = string
      allow_hosts = list(string)
    }))
  }))
  default = []
}
