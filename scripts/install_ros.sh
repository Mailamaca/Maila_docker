#!/bin/bash
#set -x #echo on

# install ros2 pkgs
apt-get update
# ros demo nodes
apt-get install -y ros-${ROS_DISTRO}-demo-nodes-cpp
apt-get install -y ros-${ROS_DISTRO}-demo-nodes-py
# ros demo turtlesim
apt-get install -y ros-${ROS_DISTRO}-turtlesim 
#
# TODO: add more!
