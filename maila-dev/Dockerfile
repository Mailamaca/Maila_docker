FROM maila/maila-base

LABEL mantainer="Paolo Tomasin <pooltomasin@hotmail.com>"
LABEL mantainer="Valerio Magnago <valerio.magnago@gmail.com>"

RUN apt-get update -qq && apt-get install -qq \
    sudo && \
    rm -rf /var/lib/apt/lists/*  

# create std user named snail
RUN useradd --create-home -ms /bin/bash snail
RUN usermod -aG sudo snail

# set user passwords
RUN echo 'root:root' |chpasswd
RUN echo 'snail:snail' |chpasswd

# add hostname
RUN echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" > /etc/hosts
RUN echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
RUN echo "127.0.0.1   $HOSTNAME" >> /etc/hosts

# setup ssh
RUN mkdir /var/run/sshd && \
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# install packages
RUN apt-get update -qq && apt-get install -qq \
    python3-vcstool \
    libwiringpi-dev \
    libgps-dev \
    gpsd \
    gpsd-clients \
    fonts-powerline \
    libbluetooth-dev \
    libcwiid-dev && \
    rm -rf /var/lib/apt/lists/*    

# Install ros2 pkg
RUN apt-get update -qq && apt-get install -qq \
    ros-${ROS_DISTRO}-diagnostic-msgs \
    ros-${ROS_DISTRO}-diagnostic-updater \
    ros-${ROS_DISTRO}-diagnostic-aggregator && \
    rm -rf /var/lib/apt/lists/*
    
# Tool to format the code
RUN apt-get update -qq && apt-get install -qq \
    ros-${ROS_DISTRO}-ament-clang-format \
    ros-${ROS_DISTRO}-ament-cmake-clang-format && \
    rm -rf /var/lib/apt/lists/*

# entrypoint is used to update uid/gid and then run the users command
COPY scripts/synth-shell/.bashrc /home/snail
COPY scripts/synth-shell/config /home/snail/.config/synth-shell

# Cleanup
RUN apt-get -qq clean all && \
    rm -r -f /tmp/* && \
    rm -r -f /dockerFiles/* && \
    rm -r -f /var/tmp/* && \
    rm -r -f /var/lib/apt/lists/*

# setup entrypoint
COPY ./entrypoint.sh /

WORKDIR /home/snail
USER snail
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]



