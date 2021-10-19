#!/bin/bash

# ReplicasCount InSyncReplicasCount ObserversInIsrCount

for metric in CaughtUpReplicasCount
do

  echo -e "\n\n==> JMX metric: $metric \n"

  for topic in single-region multi-region-sync multi-region-async multi-region-async-op-leader-is-observer
  do

    test "$(docker inspect -f '{{.State.ExitCode}}' $(docker ps -laq --filter="name=broker-north-1"))" = "0" \
      && BW1=$(docker-compose exec broker-north-1 kafka-run-class kafka.tools.JmxTool --jmx-url service:jmx:rmi:///jndi/rmi://localhost:8091/jmxrmi --object-name kafka.cluster:type=Partition,name=$metric,topic=$topic,partition=0 --one-time true | tail -n 1 | awk -F, '{print $2;}' | head -c 1) \
      || BW1=0

    test "$(docker inspect -f '{{.State.ExitCode}}' $(docker ps -laq --filter="name=broker-north-2"))" = "0" \
      && BW2=$(docker-compose exec broker-north-2 kafka-run-class kafka.tools.JmxTool --jmx-url service:jmx:rmi:///jndi/rmi://localhost:8092/jmxrmi --object-name kafka.cluster:type=Partition,name=$metric,topic=$topic,partition=0 --one-time true | tail -n 1 | awk -F, '{print $2;}' | head -c 1) \
      || BW2=0

    test "$(docker inspect -f '{{.State.ExitCode}}' $(docker ps -laq --filter="name=broker-south-3"))" = "0" \
      && BE3=$(docker-compose exec broker-south-3 kafka-run-class kafka.tools.JmxTool --jmx-url service:jmx:rmi:///jndi/rmi://localhost:8093/jmxrmi --object-name kafka.cluster:type=Partition,name=$metric,topic=$topic,partition=0 --one-time true | tail -n 1 | awk -F, '{print $2;}' | head -c 1) \
      || BE3=0

    test "$(docker inspect -f '{{.State.ExitCode}}' $(docker ps -laq --filter="name=broker-south-4"))" = "0" \
      && BE4=$(docker-compose exec broker-south-4 kafka-run-class kafka.tools.JmxTool --jmx-url service:jmx:rmi:///jndi/rmi://localhost:8094/jmxrmi --object-name kafka.cluster:type=Partition,name=$metric,topic=$topic,partition=0 --one-time true | tail -n 1 | awk -F, '{print $2;}' | head -c 1) \
      || BE4=0

    REPLICAS=$((BW1 + BW2 + BE3 + BE4))
    echo "$topic: $REPLICAS"
  done

done
