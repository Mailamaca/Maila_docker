#!/bin/bash
#set -x #echo on

# install ros2 pkgs
apt-get update && apt-get install -y \
	ros-${ROS_DISTRO}-demo-nodes-cpp \
	ros-${ROS_DISTRO}-demo-nodes-py \
	ros-${ROS_DISTRO}-turtlesim
	
# TODO: add more!
