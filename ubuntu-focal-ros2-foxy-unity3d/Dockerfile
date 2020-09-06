FROM maila/ubuntu-focal-ros2-foxy

LABEL mantainer="Paolo Tomasin <pooltomasin@hotmail.com>"
LABEL mantainer="Valerio Magnago <valerio.magnago@gmail.com>"

#refs: https://index.ros.org/doc/ros2/Installation/Foxy/Linux-Development-Setup/ 
#refs: https://github.com/DynoRobotics/dyno-docker-images/blob/master/balena-amd64-ros2/dashing-isolated-cyclone/Dockerfile

# environment vars
ENV UNITYVERSION 2019.4.8f1


# install dotnet build support
RUN bash -c '. /etc/os-release; wget -q https://packages.microsoft.com/config/${NAME,,}/${VERSION_ID,,}/packages-microsoft-prod.deb -O packages-microsoft-prod.deb'
RUN dpkg -i packages-microsoft-prod.deb

RUN apt-get update -qq && apt-get install -qq -y \
  software-properties-common

RUN add-apt-repository universe

RUN apt-get update -qq && apt-get install -qq -y \
  apt-transport-https \
  dotnet-sdk-3.1 \
  aspnetcore-runtime-3.1 \
  libunwind-dev

# Unity https://gitlab.com/gableroux/unity3d#build-the-image 
RUN apt-get update && apt-get install -qq -y \
	libgtk2.0-0 \
	libsoup2.4-1 \
	libarchive13 \
	libpng16-16 \
	libgconf-2-4 \
	lib32stdc++6 \
	libcanberra-gtk-module \
	libfuse2 \
	libnss3 \
	libasound2 \
	nautilus \
	libxss1 \
	libcwiid1 \
	libcwiid-dev \
	xz-utils

RUN wget https://beta.unity3d.com/download/60781d942082/UnitySetup-${UNITYVERSION} -O UnitySetup && \
    chmod +x UnitySetup
    
RUN echo y | ./UnitySetup \
        --unattended \
        --install-location=/opt/Unity-${UNITYVERSION} \
        --verbose \
        --download-location=/tmp/unity \
        --components=Unity

RUN ln -s /opt/Unity-${UNITYVERSION}/Editor/Unity /usr/bin/unity3d
RUN rm UnitySetup

# setup entrypoint
COPY ./entrypoint.sh /
ENTRYPOINT [""]
CMD ["bash"]
