#!/usr/bin/env bash

## Introduce latency between north and south (100ms)

NETWORK_NAME="kafka-mrc-playbook_n1"

ZOOKEEPER_SOUTH_IP=`docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' zookeeper-south`
KAFKA_SOUTH_3_IP=`docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' broker-south-3`
KAFKA_SOUTH_4_IP=`docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' broker-south-4`

docker run --rm -d \
       --network=${NETWORK_NAME} \
       --name pumba-high-latency-north-south \
       -v /var/run/docker.sock:/var/run/docker.sock \
       gaiaadm/pumba:0.7.8 -l debug netem --duration 24000h \
                --tc-image gaiadocker/iproute2 \
                --target ${ZOOKEEPER_SOUTH_IP} \
                --target ${KAFKA_SOUTH_3_IP} \
                --target ${KAFKA_SOUTH_4_IP} \
                delay --time 200 zookeeper-north broker-north-1 broker-north-2 --jitter 20 &
