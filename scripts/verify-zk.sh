#!/usr/bin/env bash

ZKs=( zookeeper-north zookeeper-central zookeeper-south)
port=2181
i=0

for zk in ${ZKs[@]}
do
 zk_port=$(($port+$i))
 echo -e "\n==> Describe zookeeper stats: $zk $zk_port\n"
 docker exec $zk bash -c "echo stat | nc $zk $zk_port"
 ((i=i+1))
done

zk=zookeeper-ccc
zk_port=2188

echo -e "\n==> Describe zookeeper stats: $zk $zk_port\n"
docker exec $zk bash -c "echo stat | nc $zk $zk_port"
