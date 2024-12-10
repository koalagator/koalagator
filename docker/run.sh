#!/bin/bash

cd $(dirname "$0")/../

#be container platform agnostic
shopt -s expand_aliases
which docker || which podman && alias docker=podman


docker build -t koalagator_dev -f docker/development.containerfile .

docker run --rm -v .:/koalagator -p 3000:3000 -it --hostname koalagator_dev koalagator_dev /bin/bash

