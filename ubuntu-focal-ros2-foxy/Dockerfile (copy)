FROM amd64/ubuntu:20.04

LABEL mantainer="Paolo Tomasin <pooltomasin@hotmail.com>"
LABEL mantainer="Valerio Magnago <valerio.magnago@gmail.com>"

#refs: https://index.ros.org/doc/ros2/Installation/Foxy/Linux-Development-Setup/ 
#refs: https://github.com/DynoRobotics/dyno-docker-images/blob/master/balena-amd64-ros2/dashing-isolated-cyclone/Dockerfile

# environment vars
ENV ROS_DISTRO foxy
ENV ROS2_WS /opt/ros2_ws
ENV ROS_CMAKE_BUILD_TYPE Release

# setup timezone and environment
RUN apt-get update -qq && apt-get install -qq -y \
    lsb-release \
    locales \
    curl \
    gnupg2 \
    tzdata
    
RUN echo 'Etc/UTC' > /etc/timezone
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

RUN locale-gen --purge en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# install utility packages
RUN apt-get update -qq && apt-get install -qq -y \
  apt-utils \
  curl \
  nano \
  wget \
  vim \
  less \
  net-tools \
  htop \
  can-utils \
  iputils-ping \
  xz-utils \
  openssh-server

# setup ros2 keys
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# setup sources.list
RUN echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list

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
  bash-completion

# clone sources
RUN mkdir -p $ROS2_WS/src
WORKDIR $ROS2_WS
RUN wget https://raw.githubusercontent.com/ros2/ros2/$ROS_DISTRO/ros2.repos
RUN vcs import src < ros2.repos

# bootstrap rosdep and install dependencies
RUN rosdep init && \
    rosdep update && \
    apt-get update -qq && \
    rosdep install -y \
    --from-paths src \
    --ignore-src \
    --rosdistro $ROS_DISTRO \
    --skip-keys "console_bridge fastcdr fastrtps rti-connext-dds-5.3.1 urdfdom_headers"

# build source
RUN colcon build --cmake-args -DCMAKE_BUILD_TYPE=$ROS_CMAKE_BUILD_TYPE

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

