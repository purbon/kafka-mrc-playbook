#!/usr/bin/env bash

echo -e "\n==> Creating topic multi-region-async-op-leader-is-observer"

docker-compose exec broker-south-3 \
    kafka-replica-status --bootstrap-server broker-south-3:19093 \
    --topics multi-region-async --partitions 0 --verbose
