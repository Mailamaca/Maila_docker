# Ubuntu 20.04 with nvidia opengl support for ignition gazebo
FROM nvidia/opengl:1.2-glvnd-devel-ubuntu20.04

LABEL mantainer="Paolo Tomasin <pooltomasin@hotmail.com>"
LABEL mantainer="Valerio Magnago <valerio.magnago@gmail.com>"

#refs: https://github.com/ignitionrobotics/ign-gazebo/blob/ign-gazebo4/docker/Dockerfile.ignition
#refs: https://index.ros.org/doc/ros2/Installation/Foxy/Linux-Development-Setup/
#refs: https://github.com/DynoRobotics/dyno-docker-images/blob/master/balena-amd64-ros2/dashing-isolated-cyclone/Dockerfile
#refs: https://github.com/osrf/docker_images/blob/30496b03a10f37d3ee54d5df672a0c27e0ab3952/ros/foxy/ubuntu/focal/ros-core/Dockerfile
#refs: https://index.ros.org/doc/ros2/Installation/DDS-Implementations/Working-with-Eclipse-CycloneDDS/
#refs: https://www.programmersought.com/article/6188661315/

# environment vars
ENV ROS_DISTRO foxy

# install packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
    && apt-get install -qq \
        software-properties-common \
        openssh-server \
        lsb-release \
        apt-utils \
        can-utils \
        locales \
        tzdata \
        gnupg2 \
        curl \
        cmake \
        make \
        nano \
        wget \
        less \
        htop \
        sudo \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# setup sources
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list

# install ros2 packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
    && apt-get install -qq \
        ros-foxy-desktop \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=

# install colcon
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install -qq \
    build-essential \
    cmake \
    python3-colcon-common-extensions && \
    rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=

# Install argcomplete
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install -qq \
    python3-pip && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install -U argcomplete
ENV DEBIAN_FRONTEND=

# install Fast-RTPS dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install -qq \
    libasio-dev \
    libtinyxml2-dev && \
    rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=

# install cyclone DDS
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install -qq \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp && \
    rm -rf /var/lib/apt/lists/*
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
ENV DEBIAN_FRONTEND=

# Copy installation scripts
COPY scripts /tmp/install_scripts
WORKDIR /tmp/install_scripts

# setup GCC and CLANG Toolchains
RUN chmod +x setup_GCC_and_CLANG_Toolchains.sh
ENV DEBIAN_FRONTEND=noninteractive
RUN ./setup_GCC_and_CLANG_Toolchains.sh
ENV DEBIAN_FRONTEND=

# cleanup
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq clean all && \
    rm -r -f /tmp/* && \
    rm -r -f /dockerFiles/* && \
    rm -r -f /var/tmp/* && \
    rm -r -f /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=

CMD ["bash"]
