FROM amd64/ros:foxy-ros-base-focal

MAINTAINER Paolo Tomasin <pooltomasin@hotmail.com>
MAINTAINER Valerio Magnago <valerio.magnago@gmail.com>

# environment variables
ENV TIME_ZONE=UTC
ENV ZA_USESSH=1

# set root password
RUN echo 'root:root' |chpasswd

# create std user
RUN useradd --create-home -ms /bin/bash user
RUN echo 'user:user' |chpasswd

# timezone
RUN ln -s -f /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime

# copy all scripts
ADD scripts /scripts/
ADD files /files/

# # SSH
# RUN /scripts/install_ssh.sh
# EXPOSE 22
# CMD ["/usr/sbin/sshd", "-D"]



# # ROS
# # RUN /scripts/install_ros.sh

USER user
WORKDIR /home/user

# setup ROS2 environment
#RUN "source /opt/ros/foxy/setup.bash" DO NOT WORK

# NOTE:
# if run with ssh remove comment 'USER user' and, at the end add 'CMD ["/usr/sbin/sshd", "-D"]'



