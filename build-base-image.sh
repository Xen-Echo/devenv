#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

podman build -t base -f $SCRIPT_DIR/containers/base.Containerfile
