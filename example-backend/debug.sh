#!/bin/sh

exec /usr/local/bin/consul agent -data-dir=/data -config-dir=/config \
  -bind $CONTAINERPILOT_EXAMPLE_IP \
  -log-level debug \
  -rejoin -retry-join $CONSUL -retry-max 10 -retry-interval 10s