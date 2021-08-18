#! /usr/bin/env bash

branch=topic/christian/cluster-controller-next

docker build -t ckreibich/zeek --build-arg branch=$branch zeek
docker build -t ckreibich/zeek-client --build-arg branch=$branch zeek-client
