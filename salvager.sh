#!/bin/bash

path_dok=$(readlink -f "$1")
path_out=$(readlink -f "$2")

docker-compose run \
    --volume "$path_dok:/dok:ro" \
    --volume "$path_out:/src" \
    salvager
