#!/usr/bin/env bash

set -euo pipefail
shopt -s nullglob

VOLUMES="minecraft-server-dev_velocity-logs minecraft-server-dev_minecraft minecraft-server-dev_minecraft-logs"

for volume in $VOLUMES; do
  echo " Deleting docker volume: $volume"
  docker volume rm "$volume"
done

# TODO: delete folders with uneeded stuff
