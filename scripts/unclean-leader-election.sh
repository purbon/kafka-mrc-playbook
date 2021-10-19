#!/usr/bin/env bash


echo -e "\n==> Unclean leader election for topic multi-region-async-op-leader-is-observer"

docker-compose exec broker-south-3 kafka-leader-election \
  --bootstrap-server broker-south-3:19093 \
  --election-type UNCLEAN \
  --path-to-json-file /etc/kafka/demo/unclean-election.json
