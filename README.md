# Yandex Cloud <RESOURCE> Terraform module

Terraform module which creates Yandex Cloud <RESOURCE> resources.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment of the Kafka cluster | `string` | `"PRODUCTION"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The ID of the folder that the resource belongs to | `string` | `null` | no |
| <a name="input_host_group_ids"></a> [host\_group\_ids](#input\_host\_group\_ids) | A list of IDs of the host groups to place VMs of the cluster on | `list(string)` | `[]` | no |
| <a name="input_kafka_compression_type"></a> [kafka\_compression\_type](#input\_kafka\_compression\_type) | Kafka server compression type | `string` | `null` | no |
| <a name="input_kafka_disk_size"></a> [kafka\_disk\_size](#input\_kafka\_disk\_size) | Volume of the storage available to a Kafka host, in gigabytes | `number` | n/a | yes |
| <a name="input_kafka_disk_type_id"></a> [kafka\_disk\_type\_id](#input\_kafka\_disk\_type\_id) | Type of the storage of Kafka hosts | `string` | n/a | yes |
| <a name="input_kafka_log_flush_interval_messages"></a> [kafka\_log\_flush\_interval\_messages](#input\_kafka\_log\_flush\_interval\_messages) | Kafka server log flush interval messages | `number` | `null` | no |
| <a name="input_kafka_resource_preset_id"></a> [kafka\_resource\_preset\_id](#input\_kafka\_resource\_preset\_id) | The ID of the preset for computational resources available to a Kafka host | `string` | n/a | yes |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version) | Version of the Kafka server software | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the Kafka cluster | `map(string)` | `{}` | no |
| <a name="input_maintenance_window_day"></a> [maintenance\_window\_day](#input\_maintenance\_window\_day) | Day of the week for maintenance window | `string` | `null` | no |
| <a name="input_maintenance_window_hour"></a> [maintenance\_window\_hour](#input\_maintenance\_window\_hour) | Hour of the day in UTC for maintenance window | `number` | `null` | no |
| <a name="input_maintenance_window_type"></a> [maintenance\_window\_type](#input\_maintenance\_window\_type) | Type of maintenance window | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | ID of the network, to which the Kafka cluster belongs | `string` | n/a | yes |
| <a name="input_schema_registry"></a> [schema\_registry](#input\_schema\_registry) | Enables managed schema registry on cluster | `bool` | `false` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group ids, to which the Kafka cluster belongs | `list(string)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | IDs of the subnets, to which the Kafka cluster belongs | `list(string)` | `[]` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | List of Kafka topics to create | <pre>list(object({<br>    name               = string<br>    partitions         = number<br>    replication_factor = number<br>    config = object({<br>      cleanup_policy        = string<br>      compression_type      = string<br>      delete_retention_ms   = number<br>      file_delete_delay_ms  = number<br>      flush_messages        = number<br>      flush_ms              = number<br>      min_compaction_lag_ms = number<br>      retention_bytes       = number<br>      retention_ms          = number<br>      max_message_bytes     = number<br>      min_insync_replicas   = number<br>      segment_bytes         = number<br>      preallocate           = bool<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_users"></a> [users](#input\_users) | List of Kafka users to create | <pre>list(object({<br>    name     = string<br>    password = string<br>    permissions = list(object({<br>      topic_name  = string<br>      role        = string<br>      allow_hosts = list(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | List of availability zones | `list(string)` | n/a | yes |
| <a name="input_zookeeper_disk_size"></a> [zookeeper\_disk\_size](#input\_zookeeper\_disk\_size) | Volume of the storage available to a ZooKeeper host, in gigabytes | `number` | n/a | yes |
| <a name="input_zookeeper_disk_type_id"></a> [zookeeper\_disk\_type\_id](#input\_zookeeper\_disk\_type\_id) | Type of the storage of ZooKeeper hosts | `string` | n/a | yes |
| <a name="input_zookeeper_resource_preset_id"></a> [zookeeper\_resource\_preset\_id](#input\_zookeeper\_resource\_preset\_id) | The ID of the preset for computational resources available to a ZooKeeper host | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Timestamp of cluster creation |
| <a name="output_hosts"></a> [hosts](#output\_hosts) | A host of the Kafka cluster |
| <a name="output_kafka_cluster_id"></a> [kafka\_cluster\_id](#output\_kafka\_cluster\_id) | ID of the Kafka cluster |
| <a name="output_kafka_topic_ids"></a> [kafka\_topic\_ids](#output\_kafka\_topic\_ids) | IDs of the Kafka topics |
| <a name="output_kafka_user_ids"></a> [kafka\_user\_ids](#output\_kafka\_user\_ids) | IDs of the Kafka users |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
