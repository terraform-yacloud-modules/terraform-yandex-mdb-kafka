output "created_at" {
  description = "Timestamp of cluster creation"
  value       = yandex_mdb_kafka_cluster.kafka_cluster.created_at
}

output "kafka_topic_id" {
  description = "ID of the Kafka topic"
  value       = yandex_mdb_kafka_topic.kafka_topic.id
}

output "kafka_cluster_id" {
  description = "ID of the Kafka cluster"
  value       = yandex_mdb_kafka_cluster.kafka_cluster.id
}

output "hosts" {
  description = "A host of the Kafka cluster"
  value       = yandex_mdb_kafka_cluster.kafka_cluster.host
}
output "kafka_user_id" {
  description = "ID of the Kafka user"
  value       = yandex_mdb_kafka_user.kafka_user.id
}
