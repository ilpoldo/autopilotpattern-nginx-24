Running a consul coprocess on docker swarm
------------------------------------------

example for [issue#24](https://github.com/autopilotpattern/nginx/issues/24) of autopilotpattern/nginx

Running `bash with_compose.sh` and `bash with_swarm.sh` will launch the example services from `autopilotpattern/nginx` on docker compose or docker swarm after building a local version of one of the images.

Before running `bash with_swarm.sh` it will be necessary to run `swarm init` first.