#!/usr/bin/env bash

set -xe

docker run -it \
       --rm \
       --privileged \
       --network=host \
       --device=/dev/kfd \
       --device=/dev/dri \
       --ipc=host \
       --group-add video \
       --group-add render \
       --cap-add=SYS_PTRACE \
       --security-opt seccomp=unconfined \
       -v $(pwd):$(pwd) \
       -v root_cache:/root/.cache \
       --env HSA_OVERRIDE_GFX_VERSION=10.3.0 \
       --workdir $(pwd) \
       rocm/pytorch:latest
