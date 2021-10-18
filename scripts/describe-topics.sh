#!/usr/bin/env bash

TOPICS=( single-region multi-region-sync multi-region-async)
for topic in ${TOPICS[@]}
do
 echo -e "\n==> Describe topic: $topic\n"

  docker-compose exec broker-south-3 kafka-topics --bootstrap-server broker-south-3:19093 --describe --topic $topic
done
