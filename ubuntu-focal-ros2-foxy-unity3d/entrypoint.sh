#!/bin/bash
set -e

# setup ros2 environment
source "${ROS2_WS}/install/local_setup.bash"
source "${DOTNET_WS}/install/local_setup.bash"

exec "$@"
