#!/bin/bash
set -e

# setup ros2 environment
source "/opt/ros/foxy/setup.bash"
#source "${DOTNET_WS}/install/local_setup.bash"

exec "$@"
