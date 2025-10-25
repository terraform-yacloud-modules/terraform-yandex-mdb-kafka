# Yandex Cloud Managed Service for Apache Kafka Terraform module

Terraform module which creates Yandex Cloud Managed Service for Apache Kafka (MDB Kafka) resources.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_mdb_kafka_cluster.kafka_cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster) | resource |
| [yandex_mdb_kafka_topic.kafka_topic](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_topic) | resource |
| [yandex_mdb_kafka_user.kafka_user](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Determines whether each broker will be assigned a public IP address | `bool` | `false` | no |
| <a name="input_brokers_count"></a> [brokers\_count](#input\_brokers\_count) | Count of brokers per availability zone | `number` | `1` | no |
| <a name="input_cluster_description"></a> [cluster\_description](#input\_cluster\_description) | Description of the Kafka cluster | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Kafka cluster | `string` | n/a | yes |
| <a name="input_data_transfer_access"></a> [data\_transfer\_access](#input\_data\_transfer\_access) | Allow access for DataTransfer | `bool` | `false` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Inhibits deletion of the cluster | `bool` | `false` | no |
| <a name="input_disk_size_autoscaling"></a> [disk\_size\_autoscaling](#input\_disk\_size\_autoscaling) | Disk size autoscaling configuration | <pre>object({<br/>    disk_size_limit           = number<br/>    planned_usage_threshold   = optional(number)<br/>    emergency_usage_threshold = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment of the Kafka cluster | `string` | `"PRODUCTION"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The ID of the folder that the resource belongs to | `string` | `null` | no |
| <a name="input_host_group_ids"></a> [host\_group\_ids](#input\_host\_group\_ids) | A list of IDs of the host groups to place VMs of the cluster on | `list(string)` | `[]` | no |
| <a name="input_kafka_compression_type"></a> [kafka\_compression\_type](#input\_kafka\_compression\_type) | Kafka server compression type | `string` | `null` | no |
| <a name="input_kafka_default_replication_factor"></a> [kafka\_default\_replication\_factor](#input\_kafka\_default\_replication\_factor) | Kafka server default replication factor | `number` | `null` | no |
| <a name="input_kafka_disk_size"></a> [kafka\_disk\_size](#input\_kafka\_disk\_size) | Volume of the storage available to a Kafka host, in gigabytes | `number` | n/a | yes |
| <a name="input_kafka_disk_type_id"></a> [kafka\_disk\_type\_id](#input\_kafka\_disk\_type\_id) | Type of the storage of Kafka hosts | `string` | n/a | yes |
| <a name="input_kafka_log_flush_interval_messages"></a> [kafka\_log\_flush\_interval\_messages](#input\_kafka\_log\_flush\_interval\_messages) | Kafka server log flush interval messages | `number` | `null` | no |
| <a name="input_kafka_log_flush_interval_ms"></a> [kafka\_log\_flush\_interval\_ms](#input\_kafka\_log\_flush\_interval\_ms) | Kafka server log flush interval milliseconds | `number` | `null` | no |
| <a name="input_kafka_log_flush_scheduler_interval_ms"></a> [kafka\_log\_flush\_scheduler\_interval\_ms](#input\_kafka\_log\_flush\_scheduler\_interval\_ms) | Kafka server log flush scheduler interval milliseconds | `number` | `null` | no |
| <a name="input_kafka_log_retention_bytes"></a> [kafka\_log\_retention\_bytes](#input\_kafka\_log\_retention\_bytes) | Kafka server log retention bytes | `number` | `null` | no |
| <a name="input_kafka_log_retention_hours"></a> [kafka\_log\_retention\_hours](#input\_kafka\_log\_retention\_hours) | Kafka server log retention hours | `number` | `null` | no |
| <a name="input_kafka_log_retention_minutes"></a> [kafka\_log\_retention\_minutes](#input\_kafka\_log\_retention\_minutes) | Kafka server log retention minutes | `number` | `null` | no |
| <a name="input_kafka_log_retention_ms"></a> [kafka\_log\_retention\_ms](#input\_kafka\_log\_retention\_ms) | Kafka server log retention milliseconds | `number` | `null` | no |
| <a name="input_kafka_log_segment_bytes"></a> [kafka\_log\_segment\_bytes](#input\_kafka\_log\_segment\_bytes) | Kafka server log segment bytes | `number` | `null` | no |
| <a name="input_kafka_message_max_bytes"></a> [kafka\_message\_max\_bytes](#input\_kafka\_message\_max\_bytes) | Kafka server message max bytes | `number` | `null` | no |
| <a name="input_kafka_num_partitions"></a> [kafka\_num\_partitions](#input\_kafka\_num\_partitions) | Kafka server number of partitions | `number` | `null` | no |
| <a name="input_kafka_offsets_retention_minutes"></a> [kafka\_offsets\_retention\_minutes](#input\_kafka\_offsets\_retention\_minutes) | Kafka server offsets retention minutes | `number` | `null` | no |
| <a name="input_kafka_replica_fetch_max_bytes"></a> [kafka\_replica\_fetch\_max\_bytes](#input\_kafka\_replica\_fetch\_max\_bytes) | Kafka server replica fetch max bytes | `number` | `null` | no |
| <a name="input_kafka_resource_preset_id"></a> [kafka\_resource\_preset\_id](#input\_kafka\_resource\_preset\_id) | The ID of the preset for computational resources available to a Kafka host | `string` | n/a | yes |
| <a name="input_kafka_sasl_enabled_mechanisms"></a> [kafka\_sasl\_enabled\_mechanisms](#input\_kafka\_sasl\_enabled\_mechanisms) | Kafka server SASL enabled mechanisms | `list(string)` | `null` | no |
| <a name="input_kafka_ssl_cipher_suites"></a> [kafka\_ssl\_cipher\_suites](#input\_kafka\_ssl\_cipher\_suites) | Kafka server SSL cipher suites | `list(string)` | `null` | no |
| <a name="input_kafka_ui_enabled"></a> [kafka\_ui\_enabled](#input\_kafka\_ui\_enabled) | Enable Kafka UI for cluster | `bool` | `false` | no |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version) | Version of the Kafka server | `string` | n/a | yes |
| <a name="input_kraft_disk_size"></a> [kraft\_disk\_size](#input\_kraft\_disk\_size) | Volume of the storage available to a KRaft host, in gigabytes | `number` | `null` | no |
| <a name="input_kraft_disk_type_id"></a> [kraft\_disk\_type\_id](#input\_kraft\_disk\_type\_id) | Type of the storage of KRaft hosts | `string` | `null` | no |
| <a name="input_kraft_resource_preset_id"></a> [kraft\_resource\_preset\_id](#input\_kraft\_resource\_preset\_id) | The ID of the preset for computational resources available to a KRaft host | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the Kafka cluster | `map(string)` | `{}` | no |
| <a name="input_maintenance_window_day"></a> [maintenance\_window\_day](#input\_maintenance\_window\_day) | Day of the week for maintenance window | `string` | `null` | no |
| <a name="input_maintenance_window_hour"></a> [maintenance\_window\_hour](#input\_maintenance\_window\_hour) | Hour of the day in UTC for maintenance window | `number` | `null` | no |
| <a name="input_maintenance_window_type"></a> [maintenance\_window\_type](#input\_maintenance\_window\_type) | Type of maintenance window | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | ID of the network, to which the Kafka cluster belongs | `string` | n/a | yes |
| <a name="input_rest_api_enabled"></a> [rest\_api\_enabled](#input\_rest\_api\_enabled) | Enable REST API for Kafka cluster | `bool` | `false` | no |
| <a name="input_schema_registry"></a> [schema\_registry](#input\_schema\_registry) | Enables managed schema registry on cluster | `bool` | `false` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group ids, to which the Kafka cluster belongs | `list(string)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | IDs of the subnets, to which the Kafka cluster belongs | `list(string)` | `[]` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeout settings for cluster operations | <pre>object({<br/>    create = optional(string, "30m")<br/>    update = optional(string, "30m")<br/>    delete = optional(string, "30m")<br/>  })</pre> | `null` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | (Required) This is a list of Kafka topics to create.<br/><br/>    Required values:<br/>      - name               - The name of the topic.<br/>      - partitions         - The number of partitions for the topic.<br/>      - replication\_factor - The replication factor for the topic.<br/><br/>    Optional values:<br/>      - config             - Configuration settings for the topic. The list is documented below.<br/>        - cleanup\_policy        - (Optional) The cleanup policy for the topic. Allowed values: `CLEANUP_POLICY_DELETE`, `CLEANUP_POLICY_COMPACT`, `CLEANUP_POLICY_COMPACT_AND_DELETE`.<br/>        - compression\_type      - (Optional) The compression type for the topic. Allowed values: `COMPRESSION_TYPE_SNAPPY`, `COMPRESSION_TYPE_GZIP`, `COMPRESSION_TYPE_PRODUCER`, `COMPRESSION_TYPE_UNCOMPRESSED`, `COMPRESSION_TYPE_ZSTD`, `COMPRESSION_TYPE_LZ4`.<br/>        - delete\_retention\_ms   - (Optional) The time to retain delete tombstone markers for log compacted topics.<br/>        - file\_delete\_delay\_ms  - (Optional) The time to wait before deleting a file from the filesystem.<br/>        - flush\_messages        - (Optional) The number of messages accumulated on a log partition before messages are flushed to disk.<br/>        - flush\_ms              - (Optional) The maximum time in milliseconds that a message in any topic is kept in memory before flushed to disk.<br/>        - min\_compaction\_lag\_ms - (Optional) The minimum time a message will remain uncompacted in the log.<br/>        - retention\_bytes       - (Optional) The maximum size a partition can grow to before Kafka will discard old log segments to free up space.<br/>        - retention\_ms          - (Optional) The maximum time Kafka will retain messages in a topic.<br/>        - max\_message\_bytes     - (Optional) The largest record batch size allowed by Kafka.<br/>        - min\_insync\_replicas   - (Optional) The minimum number of replicas that must acknowledge a write for the write to be considered successful.<br/>        - segment\_bytes         - (Optional) The maximum size of a single log file.<br/>        - preallocate           - (Optional) Whether to preallocate the file on disk. | <pre>list(object({<br/>    name               = string<br/>    partitions         = number<br/>    replication_factor = number<br/>    config = optional(object({<br/>      cleanup_policy        = optional(string, "CLEANUP_POLICY_DELETE")<br/>      compression_type      = optional(string, "COMPRESSION_TYPE_PRODUCER")<br/>      delete_retention_ms   = optional(number, 86400000)<br/>      file_delete_delay_ms  = optional(number, 60000)<br/>      flush_messages        = optional(number, 9223372036854775807)<br/>      flush_ms              = optional(number, 9223372036854775807)<br/>      min_compaction_lag_ms = optional(number, 0)<br/>      retention_bytes       = optional(number, -1)<br/>      retention_ms          = optional(number, 604800000)<br/>      max_message_bytes     = optional(number, 1048588)<br/>      min_insync_replicas   = optional(number, 1)<br/>      segment_bytes         = optional(number, 1073741824)<br/>      preallocate           = optional(bool, false)<br/>    }), null)<br/>  }))</pre> | `[]` | no |
| <a name="input_users"></a> [users](#input\_users) | List of Kafka users to create | <pre>list(object({<br/>    name     = string<br/>    password = string<br/>    permissions = list(object({<br/>      topic_name  = string<br/>      role        = string<br/>      allow_hosts = list(string)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | List of availability zones | `list(string)` | n/a | yes |
| <a name="input_zookeeper_disk_size"></a> [zookeeper\_disk\_size](#input\_zookeeper\_disk\_size) | Volume of the storage available to a ZooKeeper host, in gigabytes | `number` | `null` | no |
| <a name="input_zookeeper_disk_type_id"></a> [zookeeper\_disk\_type\_id](#input\_zookeeper\_disk\_type\_id) | Type of the storage of ZooKeeper hosts | `string` | `null` | no |
| <a name="input_zookeeper_resource_preset_id"></a> [zookeeper\_resource\_preset\_id](#input\_zookeeper\_resource\_preset\_id) | The ID of the preset for computational resources available to a ZooKeeper host | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Timestamp of cluster creation |
| <a name="output_hosts"></a> [hosts](#output\_hosts) | A host of the Kafka cluster |
| <a name="output_kafka_cluster_id"></a> [kafka\_cluster\_id](#output\_kafka\_cluster\_id) | ID of the Kafka cluster |
| <a name="output_kafka_topic_ids"></a> [kafka\_topic\_ids](#output\_kafka\_topic\_ids) | IDs of the Kafka topics |
| <a name="output_kafka_user_ids"></a> [kafka\_user\_ids](#output\_kafka\_user\_ids) | IDs of the Kafka users |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
