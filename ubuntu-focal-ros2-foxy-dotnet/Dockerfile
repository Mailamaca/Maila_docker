FROM maila/ubuntu-focal-ros2-foxy

LABEL mantainer="Paolo Tomasin <pooltomasin@hotmail.com>"
LABEL mantainer="Valerio Magnago <valerio.magnago@gmail.com>"

#refs: https://index.ros.org/doc/ros2/Installation/Foxy/Linux-Development-Setup/ 
#refs: https://github.com/DynoRobotics/dyno-docker-images/blob/master/balena-amd64-ros2/dashing-isolated-cyclone/Dockerfile

# environment vars
ENV ROS2_WS /opt/ros2_ws
ENV DOTNET_WS /opt/dotnet_ws

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

# clone source# build 
RUN mkdir -p $DOTNET_WS/src
WORKDIR $DOTNET_WS
#RUN wget https://raw.githubusercontent.com/ros2-dotnet/ros2_dotnet/master/ros2_dotnet.repos
RUN wget https://raw.githubusercontent.com/Mailamaca/ros2_dotnet/foxy/ros2_dotnet.repos
RUN vcs import src < ros2_dotnet.repos

# build source
WORKDIR $DOTNET_WS
RUN bash -c "source ${ROS2_WS}/install/local_setup.bash; colcon build"
RUN bash -c "source ${ROS2_WS}/install/local_setup.bash; source ${DOTNET_WS}/install/local_setup.bash; ros2 run rcldotnet_utils create_unity_plugin"

# setup entrypoint
COPY ./entrypoint.sh /
ENTRYPOINT [""]
CMD ["bash"]

