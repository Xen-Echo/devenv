#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

distrobox create --nvidia --name base --image base --home $SCRIPT_DIR/home

distrobox enter base -- distrobox-export --app alacritty


