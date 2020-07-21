#!/bin/bash

# install ros2 pkgs
apt-get update
apt install ros-${ROS_DISTRO}-demo-nodes-cpp \
      ros-${ROS_DISTRO}-demo-nodes-py \
      ros-foxy-turtlesim 
# TODO: add more!
