FROM maila/maila-base

LABEL mantainer="Paolo Tomasin <pooltomasin@hotmail.com>"
LABEL mantainer="Valerio Magnago <valerio.magnago@gmail.com>"

# add hostname
#RUN echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" > /etc/hosts
#RUN echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
#RUN echo "127.0.0.1   $HOSTNAME" >> /etc/hosts

# setup ssh
RUN mkdir /var/run/sshd && \
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# usefull for VPN
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
    && apt-get -y install -qq --no-install-recommends \
        libncurses5-dev \
        libreadline-dev \
        libssl-dev \
        zlib1g-dev \
        isc-dhcp-client \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=

RUN cd /tmp/ \
    && wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/archive/ec3d052e218281dc1aa734f1bf84cf42127744aa.zip \
    && unzip ec3d052e218281dc1aa734f1bf84cf42127744aa.zip \
    && cd ./SoftEtherVPN_Stable-ec3d052e218281dc1aa734f1bf84cf42127744aa \
    && ./configure && make -j4 && make install \
    && cd .. && rm -r ./SoftEtherVPN_Stable* ec3d052e2*

# install packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
    && apt-get -y install -qq --no-install-recommends \
        libbluetooth-dev \
        python3-vcstool \
        libwiringpi-dev \
        libcwiid-dev \
        libgps-dev \
        gpsd-clients \
        gpsd \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=

# Install ros2 pkg
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
    && apt-get -y install -qq --no-install-recommends \
        ros-${ROS_DISTRO}-ros-ign \
        ros-${ROS_DISTRO}-ros-ign-bridge \
        ros-${ROS_DISTRO}-diagnostic-msgs \
        ros-${ROS_DISTRO}-diagnostic-updater \
        ros-${ROS_DISTRO}-diagnostic-aggregator \
        ros-${ROS_DISTRO}-ament-clang-format \
        ros-${ROS_DISTRO}-ament-cmake-clang-format \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=

# Cleanup
RUN apt-get autoremove -y \
    && apt-get -qq clean all \
    && rm -rf /tmp/* \
    && rm -rf /dockerFiles/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

CMD ["bash"]



