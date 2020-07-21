FROM ros:foxy

MAINTAINER Paolo Tomasin <paolo.tomasin@gmail.com>
MAINTAINER Valerio Magnago <valerio.magnago@gmail.com>

# environment variables
ENV TIME_ZONE=UTC \
    TMP_REMOVE_ME_TEST=here/to/test
    EXAMPLE_CHECK=False

# copy all scripts
ADD scripts /scripts/

# copy all files
ADD files /files/

# image setup via shell script to reduce layers and optimize final disk usage
RUN /scripts/install_main.sh

# ssh, database and apex port
EXPOSE 22 1521 8080

# launch ros package
CMD ["ros2", "launch", "demo_nodes_cpp", "talker_listener.launch.py"]

