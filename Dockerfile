FROM amd64/ros:foxy-ros-base-focal

LABEL mantainer="Paolo Tomasin <pooltomasin@hotmail.com>"
LABEL mantainer="Valerio Magnago <valerio.magnago@gmail.com>"

# run as root, let the entrypoint drop back to snail user
USER root

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO foxy

# apt update
RUN apt-get -qq update && apt-get -q -y install

# install packages
RUN apt-get install -qq -y \
    openssh-server \
    lsb-release \
    dirmngr \
    gnupg2 \
    clang \
    nano \
    curl

# synth-shell
# https://github.com/andresgongora/synth-shell
RUN apt-get -qq -y install fonts-powerline

# Install ros2 pkg
RUN apt-get install -qq -y \
	ros-${ROS_DISTRO}-demo-nodes-cpp \
	ros-${ROS_DISTRO}-demo-nodes-py \
	ros-${ROS_DISTRO}-turtlesim

# setup ssh
RUN mkdir /var/run/sshd && \
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config


# add hostname
RUN echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" > /etc/hosts
RUN echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
RUN echo "127.0.0.1   $HOSTNAME" >> /etc/hosts

# create std user named snail
RUN useradd --create-home -ms /bin/bash snail

# entrypoint is used to update uid/gid and then run the users command
COPY scripts/entrypoint.sh /entrypoint.sh
COPY scripts/synth-shell/.bashrc /home/snail
COPY scripts/synth-shell/config /home/snail/.config/synth-shell

# set user passwords
RUN echo 'root:root' |chpasswd
RUN echo 'snail:snail' |chpasswd

# Cleanup
RUN apt-get -qq clean all && \
    rm -r -f /tmp/* && \
    rm -r -f /dockerFiles/* && \
    rm -r -f /var/tmp/* && \
    rm -r -f /var/lib/apt/lists/*

#ENTRYPOINT ["/entrypoint.sh"]
WORKDIR /home/snail
CMD ["bash"]



