FROM ubuntu:20.04

LABEL mantainer="Paolo Tomasin <pooltomasin@hotmail.com>"
LABEL mantainer="Valerio Magnago <valerio.magnago@gmail.com>"

#refs: https://index.ros.org/doc/ros2/Installation/Foxy/Linux-Development-Setup/ 
#refs: https://github.com/DynoRobotics/dyno-docker-images/blob/master/balena-amd64-ros2/dashing-isolated-cyclone/Dockerfile
#refs: https://github.com/osrf/docker_images/blob/30496b03a10f37d3ee54d5df672a0c27e0ab3952/ros/foxy/ubuntu/focal/ros-core/Dockerfile
#refs: https://index.ros.org/doc/ros2/Installation/DDS-Implementations/Working-with-Eclipse-CycloneDDS/

# environment vars
ENV ROS_DISTRO foxy

# install packages
RUN apt-get update -qq && apt-get install -qq \
  lsb-release \
  apt-utils \
  locales \
  curl \
  gnupg2 \
  tzdata && \
  rm -rf /var/lib/apt/lists/*
  
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
RUN apt-get update -qq && apt-get install -qq \
    ros-foxy-desktop && \
    rm -rf /var/lib/apt/lists/*

# Install argcomplete
RUN apt-get update -qq && apt-get install -qq \
    python3-pip && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install -U argcomplete
    
# install cyclone DDS
RUN apt-get update -qq && apt-get install -qq \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp && \
    rm -rf /var/lib/apt/lists/*
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

# install utility packages
RUN apt-get update -qq && apt-get install -qq \
    nano \
    wget \
    vim \
    less \
    net-tools \
    htop \
    can-utils \
    iputils-ping \
    xz-utils \
    openssh-server && \
    rm -rf /var/lib/apt/lists/*

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
