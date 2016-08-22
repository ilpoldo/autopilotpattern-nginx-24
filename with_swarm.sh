#!/usr/bin/env bash

docker build example-backend -t my-nginx-example-app

function teardown_helper {
    docker service rm consul example nginx
    docker network rm autopilot
}
trap teardown_helper EXIT

docker network create -d overlay autopilot

docker service create --name consul  -e CONSUL=consul \
--network autopilot --replicas 3 -p 8500:8500/tcp \
autopilotpattern/consul /usr/local/bin/containerpilot /bin/consul agent \
-server -bootstrap-expect 3 \
-config-dir=/etc/consul -ui-dir /ui

docker service create --name example --network autopilot \
-e CONSUL_AGENT=1 -e CONSUL=consul -e SERVICE_NAME=example \
-p 4000:4000/tcp my-nginx-example-app

docker service create --name nginx --network autopilot \
-e CONSUL_AGENT=1 -e CONSUL=consul -e BACKEND=example \
-p 80:80/tcp -p 9090:9090/tcp autopilotpattern/nginx

example_container=""
while [ -z "$example_container" ]
do
  example_container=$(docker ps -q -f "ancestor=my-nginx-example-app")
done

docker logs -f $example_container