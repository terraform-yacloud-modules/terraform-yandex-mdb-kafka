output "created_at" {
  description = "Timestamp of cluster creation"
  value       = yandex_mdb_kafka_cluster.kafka_cluster.created_at
}

output "hosts" {
  description = "A host of the Kafka cluster"
  value       = yandex_mdb_kafka_cluster.kafka_cluster.host
}
