#!/usr/bin/env bash


echo -e "\n==> Fallback leader election for topic multi-region-async-op-leader-is-observer"

docker-compose exec broker-south-3 kafka-leader-election \
  --bootstrap-server broker-south-3:19093 \
  --election-type preferred --all-topic-partitions
