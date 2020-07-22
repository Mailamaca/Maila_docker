#!/bin/bash
set -e

echo "ENTRYPOINT!"

## setup ros2 environment
#source "/opt/ros/$ROS_DISTRO/setup.bash"
echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
exec "$@"
