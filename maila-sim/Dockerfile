FROM ubuntu-focal-ros2-foxy-unity3d

LABEL mantainer="Paolo Tomasin <pooltomasin@hotmail.com>"
LABEL mantainer="Valerio Magnago <valerio.magnago@gmail.com>"

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO foxy

# install packages
RUN apt-get update -qq && apt-get install -qq -y \
    lsb-release \
    dirmngr \
    gnupg2 \
    clang \
    nano \
    curl \
    libasio-dev \
    libglu1-mesa-dev

# add hostname
RUN echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" > /etc/hosts
RUN echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
RUN echo "127.0.0.1   $HOSTNAME" >> /etc/hosts

# create std user named snail
RUN useradd --create-home -ms /bin/bash snail
RUN usermod -aG sudo snail

# set user passwords
RUN echo 'root:root' |chpasswd
RUN echo 'snail:snail' |chpasswd

# UnityHub
RUN wget https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage -O /home/snail/UnityHub.AppImage && \
    chmod +x /home/snail/UnityHub.AppImage

# Cleanup
RUN apt-get -qq clean all && \
    rm -r -f /tmp/* && \
    rm -r -f /dockerFiles/* && \
    rm -r -f /var/tmp/* && \
    rm -r -f /var/lib/apt/lists/*

ENTRYPOINT [""]
WORKDIR /home/snail
CMD ["bash"]



