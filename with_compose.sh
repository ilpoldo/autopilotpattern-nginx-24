#!/usr/bin/env bash

docker build example-backend -t my-nginx-example-app

function teardown_helper {
    docker-compose -f local-compose.yml stop
}
trap teardown_helper EXIT

docker-compose -f local-compose.yml up -d

docker-compose -f local-compose.yml logs -f example
