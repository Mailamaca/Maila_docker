FROM amd64/ubuntu:20.04

LABEL mantainer="Paolo Tomasin <pooltomasin@hotmail.com>"
LABEL mantainer="Valerio Magnago <valerio.magnago@gmail.com>"

#refs: https://github.com/osrf/docker_images/blob/30496b03a10f37d3ee54d5df672a0c27e0ab3952/ros/foxy/ubuntu/focal/ros-core/Dockerfile
#refs: https://index.ros.org/doc/ros2/Installation/Foxy/Linux-Development-Setup/
#refs: https://github.com/DynoRobotics/dyno-docker-images/blob/master/balena-amd64-ros2/dashing-isolated-cyclone/Dockerfile

# https://github.com/phusion/baseimage-docker/issues/58
ENV DEBIAN_FRONTEND noninteractive

# Install apt-utils
RUN apt-get update -qq && apt-get install -q -y --no-install-recommends \
    apt-utils=2.0.2ubuntu0.1 \
    && rm -rf /var/lib/apt/lists/*

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update -qq && apt-get install -q -y --no-install-recommends \
    tzdata && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -q -y --no-install-recommends locales
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# environment vars
ENV RMW_IMPLEMENTATION rmw_cyclonedds_cpp
ENV ROS2_WS /opt/ros2_ws
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV ROS_DISTRO foxy

# install packages
RUN apt-get update -qq && apt-get install -q -y --no-install-recommends \
    ca-certificates \
    wget \
    curl=7.68.0-1ubuntu2.2 \
    gnupg2=2.2.19-3ubuntu2 \
    htop=2.2.0-2build1 \
    iputils-ping=3:20190709-3 \
    less=551-1ubuntu0.1 \
    nano=4.8-1ubuntu1 \
    openssh-server=1:8.2p1-4ubuntu0.1 \
    xz-utils=5.2.4-1ubuntu1 \
    lsb-release \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add the ROS 2 apt repository¶
RUN wget -qO - https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

# Install development tools and ROS tools
RUN apt-get update -qq && apt-get install -qq --no-install-recommends -y \
    build-essential \
    cmake=3.16.3-1ubuntu1 \
    git=1:2.25.1-1ubuntu3 \
    libbullet-dev \
    python3-colcon-common-extensions \
    python3-flake8 \
    python3-pip \
    python3-pytest-cov \
    python3-rosdep \
    python3-setuptools \
    python3-vcstool \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install some pip packages needed for testing
RUN python3 -m pip install -U \
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
    pytest \
    pytest-cov \
    pytest-runner \
    setuptools \
    bash-completion \
    autopep8

# Get ROS 2 code
RUN mkdir -p $ROS2_WS/src
WORKDIR $ROS2_WS
RUN wget https://raw.githubusercontent.com/ros2/ros2/foxy/ros2.repos
RUN vcs import src < ros2.repos

# bootstrap rosdep and install dependencies
WORKDIR $ROS2_WS
RUN rosdep init && \
    rosdep fix-permissions && \
    rosdep update && \
    apt-get update -qq && \
    rosdep install -y \
    --from-paths src \
    --ignore-src \
    --rosdistro $ROS_DISTRO \
    --skip-keys "console_bridge fastcdr fastrtps rti-connext-dds-5.3.1 urdfdom_headers"

# install Fast-RTPS dependencies
RUN apt-get update -qq && apt-get install -qq --no-install-recommends -y \
    libasio-dev \
    libtinyxml2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install Cyclone DDS dependencies
RUN apt-get update -qq && apt-get install -qq --no-install-recommends -y \
    libcunit1-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# build source
RUN colcon build --symlink-install

# Install cyclone DDS from apt
RUN apt-get update -qq && apt-get install -qq --no-install-recommends -y \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp

# cleanup
RUN apt-get -qq clean all && \
    rm -r -f /tmp/* && \
    rm -r -f /dockerFiles/* && \
    rm -r -f /var/tmp/* && \
    rm -r -f /var/lib/apt/lists/*

# https://github.com/phusion/baseimage-docker/issues/58#issuecomment-248621422
ENV DEBIAN_FRONTEND teletype

# setup entrypoint
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

