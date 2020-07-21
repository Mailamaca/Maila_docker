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

# copy all scripts and files
ADD scripts /scripts/
ADD files /files/

# image setup via shell script to reduce layers and optimize final disk usage
RUN /scripts/install_main.sh


USER user
WORKDIR /home/user

# NOTE:
# if run with ssh remove comment 'USER user' and, at the end add 'CMD ["/usr/sbin/sshd", "-D"]'

# entrypoint where ros env is loaded
# ENTRYPOINT ["/scripts/entrypoint.sh"]


