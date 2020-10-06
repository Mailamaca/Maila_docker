FROM amd64/ubuntu:20.04

LABEL mantainer="Paolo Tomasin <pooltomasin@hotmail.com>"
LABEL mantainer="Valerio Magnago <valerio.magnago@gmail.com>"

#refs: https://github.com/osrf/docker_images/blob/30496b03a10f37d3ee54d5df672a0c27e0ab3952/ros/foxy/ubuntu/focal/ros-core/Dockerfile
#refs: https://index.ros.org/doc/ros2/Installation/Foxy/Linux-Development-Setup/ 
#refs: https://github.com/DynoRobotics/dyno-docker-images/blob/master/balena-amd64-ros2/dashing-isolated-cyclone/Dockerfile

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
RUN echo "deb http://packages.ros.org/ros2/ubuntu focal main" > /etc/apt/sources.list.d/ros2-latest.list

# environment vars
ENV ROS2_WS /opt/ros2_ws
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO foxy

# install ros2 packages
RUN apt-get update && apt-get install -y ros-foxy-desktop \
    && rm -rf /var/lib/apt/lists/*

# install utility packages
RUN apt-get update -qq && apt-get install -qq -y \
  apt-utils \
  curl \
  nano \
  wget \
  vim \
  less \
  htop \
  iputils-ping \
  xz-utils \
  openssh-server

# install ROS2 dependencies
RUN apt-get update -qq && apt-get install -qq -y \
  build-essential \
  cmake \
  git \
  python3-colcon-common-extensions \
  python3-flake8 \
  python3-pip \
  python3-rosdep \
  python3-vcstool \
  dirmngr \
  libcunit1-dev \
  libasio-dev \
  libtinyxml2-dev

# Install pip packages
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

# install Fast-RTPS dependencies
RUN apt install --no-install-recommends -y \
  libasio-dev \
  libtinyxml2-dev

# install Cyclone DDS dependencies
RUN apt install --no-install-recommends -y \
  libcunit1-dev

# build cyclone DDS sources
RUN mkdir -p $ROS2_WS/src
WORKDIR $ROS2_WS
RUN cd $ROS2_WS/src && \
    git clone https://github.com/ros2/rmw_cyclonedds ros2/rmw_cyclonedds && \
    git clone https://github.com/eclipse-cyclonedds/cyclonedds eclipse-cyclonedds/cyclonedds

# bootstrap rosdep and install dependencies
RUN cd $ROS2_WS && rosdep init && \
    rosdep update && \
    apt-get update -qq && \
    rosdep install -y \
    --from-paths src \
    --ignore-src \
    --rosdistro $ROS_DISTRO \
    --skip-keys "console_bridge fastcdr fastrtps rti-connext-dds-5.3.1 urdfdom_headers"

# build source
RUN colcon build --packages-select rmw_cyclonedds

# cleanup
RUN apt-get -qq clean all && \
    rm -r -f /tmp/* && \
    rm -r -f /dockerFiles/* && \
    rm -r -f /var/tmp/* && \
    rm -r -f /var/lib/apt/lists/*
    

# setup entrypoint
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

