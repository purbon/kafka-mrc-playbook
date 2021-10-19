#!/usr/bin/env bash

echo -e "\n\n==> Produce: Multi-region Sync Replication (topic: multi-region-sync) \n"

# 200 records sent, 3.514691 records/sec (0.02 MB/sec), 29063.73 ms avg latency, 56531.00 ms max latency, 29444 ms 50th, 54250 ms 95th, 56312 ms 99th, 56531 ms 99.9th. (100ms)
# 200 records sent, 3.278904 records/sec (0.02 MB/sec), 31268.12 ms avg latency, 59986.00 ms max latency, 32747 ms 50th, 56361 ms 95th, 59590 ms 99th, 59986 ms 99.9th. (200ms)

docker-compose exec broker-north-1 kafka-producer-perf-test --topic multi-region-sync \
    --num-records 200 \
    --record-size 5000 \
    --throughput -1 \
    --producer-props \
        acks=all \
        bootstrap.servers=broker-north-1:19091,broker-south-3:19093 \
        compression.type=none \
        batch.size=8196

echo -e "\n\n==> Produce: Multi-region aSync Replication (topic: multi-region-async) \n"


docker-compose exec broker-south-3 kafka-producer-perf-test --topic multi-region-async \
    --num-records 200 \
    --record-size 5000 \
    --throughput -1 \
    --producer-props \
        acks=all \
        bootstrap.servers=broker-south-3:19093,broker-north-1:19091 \
        compression.type=none \
        batch.size=8196
