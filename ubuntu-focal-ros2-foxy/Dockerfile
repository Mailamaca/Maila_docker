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
RUN apt-get update -qq && apt-get install -q -y --no-install-recommends \
    apt-utils=2.0.2ubuntu0.1\
    cmake=3.16.3-1ubuntu1 \
    curl=7.68.0-1ubuntu2.2 \
    git=1:2.25.1-1ubuntu3 \
    gnupg2=2.2.19-3ubuntu2 \
    htop=2.2.0-2build1 \
    iputils-ping=3:20190709-3 \
    less=551-1ubuntu0.1 \
    nano=4.8-1ubuntu1 \
    openssh-server=1:8.2p1-4ubuntu0.1 \
    xz-utils=5.2.4-1ubuntu1 \
    && apt-get clean \
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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install ROS2 dependencies
RUN apt-get update -qq && apt-get install -qq -y \
    python3-colcon-common-extensions=0.2.1-1 \
    python3-flake8=3.7.9-2 \
    python3-pip=20.0.2-5ubuntu1.1 \
    python3-rosdep=0.19.0-1 \
    python3-vcstool=0.2.14-1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

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
    libtinyxml2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install Cyclone DDS dependencies
RUN apt install --no-install-recommends -y \
    libcunit1-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# build cyclone DDS sources
RUN mkdir -p $ROS2_WS/src
WORKDIR $ROS2_WS/src
RUN git clone https://github.com/ros2/rmw_cyclonedds ros2/rmw_cyclonedds && \
    git clone https://github.com/eclipse-cyclonedds/cyclonedds eclipse-cyclonedds/cyclonedds

# bootstrap rosdep and install dependencies
WORKDIR $ROS2_WS
RUN rosdep init && \
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

