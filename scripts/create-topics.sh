#!/usr/bin/env bash

echo -e "\n==> Creating topic single-region"

docker-compose exec broker-north-1 kafka-topics  --create \
	--bootstrap-server broker-north-1:19091 \
	--topic single-region \
	--partitions 1 \
	--replica-placement /etc/kafka/demo/placement-single-region.json \
	--config min.insync.replicas=1

echo -e "\n==> Creating topic multi-region-sync"

docker-compose exec broker-north-1 kafka-topics  --create \
  	--bootstrap-server broker-north-1:19091 \
  	--topic multi-region-sync \
  	--partitions 1 \
  	--replica-placement /etc/kafka/demo/placement-multi-region-sync.json \
  	--config min.insync.replicas=1

echo -e "\n==> Creating topic multi-region-async"

docker-compose exec broker-north-1 kafka-topics  --create \
  	--bootstrap-server broker-north-1:19091 \
  	--topic multi-region-async \
  	--partitions 1 \
  	--replica-placement /etc/kafka/demo/placement-multi-region-async.json \
  	--config min.insync.replicas=2


echo -e "\n==> Creating topic multi-region-async-op-leader-is-observer"

docker-compose exec broker-north-1 kafka-topics  --create \
  	--bootstrap-server broker-north-1:19091 \
  	--topic multi-region-async-op-leader-is-observer \
  	--partitions 2 \
  	--replica-placement /etc/kafka/demo/placement-multi-region-async-op-leader-is-observer.json \
  	--config min.insync.replicas=2
