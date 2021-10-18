#!/usr/bin/env bash

## Pause brokers in the north cluster

##
# Topic: multi-region-async	TopicId: z8ElNdQ9SzaT2ac7Siv4Ng	PartitionCount: 1	ReplicationFactor: 4	Configs: min.insync.replicas=2,confluent.placement.constraints={"version":2,"replicas":[{"count":2,"constraints":{"rack":"north"}}],"observers":[{"count":2,"constraints":{"rack":"south"}}]}
#	Topic: multi-region-async	Partition: 0	Leader: 1	Replicas: 1,2,3,4	Isr: 1,2	Offline: 	Observers: 3,4
# ***
# Topic: multi-region-async	TopicId: z8ElNdQ9SzaT2ac7Siv4Ng	PartitionCount: 1	ReplicationFactor: 4	Configs: min.insync.replicas=2,confluent.placement.constraints={"version":2,"replicas":[{"count":2,"constraints":{"rack":"north"}}],"observers":[{"count":2,"constraints":{"rack":"south"}}]}
#	Topic: multi-region-async	Partition: 0	Leader: 1	Replicas: 1,2,3,4	Isr: 1,3	Offline: 2	Observers: 3,4
##

NETWORK_NAME="kafka-mrc-playbook_n1"

docker run --rm -d \
       --network=${NETWORK_NAME} \
       --name pumba-pause-north-brokers \
       -v /var/run/docker.sock:/var/run/docker.sock \
       gaiaadm/pumba:0.7.8  \
                pause --duration 5m broker-north-2  &
