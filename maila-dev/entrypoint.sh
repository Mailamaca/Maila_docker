#!/bin/bash
set -e

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
echo "source /home/snail/Workspace/Maila/install/setup.sh" > /home/snail/.bashrc
exec "$@"
