#!/usr/bin/env bash

TOPIC="multi-region-async-op-leader-is-observer"

echo -e "\n ==> Switch observers for replicas in topic $TOPIC \n"
docker-compose exec broker-south-3 kafka-configs \
	--bootstrap-server broker-south-3:19093 \
	--alter \
	--topic $TOPIC \
	--replica-placement /etc/kafka/demo/placement-multi-region-default-reverse.json

  echo -e "\n==> Running Confluent Rebalancer on $TOPIC\n"

  docker-compose exec broker-south-3 confluent-rebalancer execute \
  	--metrics-bootstrap-server broker-ccc:19098 \
  	--bootstrap-server broker-south-3:19093 \
  	--replica-placement-only \
  	--topics $TOPIC \
  	--force \
  	--throttle 10000000


docker-compose exec broker-south-3 confluent-rebalancer finish \
    	--bootstrap-server broker-south-3:19093
