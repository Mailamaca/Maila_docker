FROM amd64/ros:foxy-ros-base-focal

MAINTAINER Paolo Tomasin <pooltomasin@hotmail.com>
MAINTAINER Valerio Magnago <valerio.magnago@gmail.com>

# environment variables
ENV TIME_ZONE=UTC
ENV ZA_USESSH=0

# set root password
RUN echo 'root:root' |chpasswd

# create std user named snail
RUN useradd --create-home -ms /bin/bash snail
RUN echo 'snail:snail' |chpasswd

# timezone
RUN ln -s -f /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime

# create a local folder to store some files useful when building docker image
RUN mkdir /dockerScripts && chmod -R 777 /dockerScripts
RUN mkdir /dockerFiles && chmod -R 777 /dockerFiles

# image setup via shell script to reduce layers and optimize final disk usage
COPY scripts/image_setup.sh /dockerScripts/image_setup.sh
RUN /dockerScripts/image_setup.sh

# install ssh deamon
COPY scripts/install_ssh.sh /dockerScripts/install_ssh.sh
RUN /dockerScripts/install_ssh.sh

# install APT pkgs
COPY scripts/install_apt.sh /dockerScripts/install_apt.sh
RUN /dockerScripts/install_apt.sh

# install ROS pkgs
COPY scripts/install_ros.sh /dockerScripts/install_ros.sh
RUN /dockerScripts/install_ros.sh

# cleanup apt cache
COPY scripts/cleanup.sh /dockerScripts/cleanup.sh
RUN /dockerScripts/cleanup.sh


# entrypoint
USER snail
COPY scripts/entrypoint.sh /dockerScripts/entrypoint.sh
ENTRYPOINT ["/dockerScripts/entrypoint.sh"]
CMD ["bash"]


# NOTE:
# if run with ssh remove comment 'USER user' and, at the end add 'CMD ["/usr/sbin/sshd", "-D"]'



