#!/bin/bash
#set -x #echo on

# install ros2 pkgs
apt-get update && apt-get install -y \
	ros-${ROS_DISTRO}-demo-nodes-cpp \
	ros-${ROS_DISTRO}-demo-nodes-py \
	ros-${ROS_DISTRO}-turtlesim
	
# Install development tools and ROS tools
# https://index.ros.org/doc/ros2/Installation/Foxy/Linux-Development-Setup/#install-development-tools-and-ros-tools
sudo apt update && sudo apt install -y \
  build-essential \
  cmake \
  git \
  libbullet-dev \
  python3-colcon-common-extensions \
  python3-flake8 \
  python3-pip \
  python3-pytest-cov \
  python3-rosdep \
  python3-setuptools \
  python3-vcstool \
  wget
# install some pip packages needed for testing
python3 -m pip install -U \
  argcomplete \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest
# install Fast-RTPS dependencies
sudo apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev
# install Cyclone DDS dependencies
sudo apt install --no-install-recommends -y \
  libcunit1-dev

# Install argcomplete (optional)
# https://index.ros.org/doc/ros2/Installation/Foxy/Linux-Development-Setup/#install-argcomplete-optional
sudo apt install python3-argcomplete

# Install rqt
# https://index.ros.org/doc/ros2/Tutorials/Turtlesim/Introducing-Turtlesim/#install-rqt
sudo apt install ~nros-<distro>-rqt*
