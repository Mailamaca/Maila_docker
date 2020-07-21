# Docker -  Development Environment

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)
[![Open Source Love png2](https://badges.frapsoft.com/os/v2/open-source.png?v=103)](https://github.com/ellerbrock/open-source-badges/)

To ensure a common, consistent development environment we develop a docker image to run all the packages required from the *Maila* project.

## Content

This Docker Image contains the following:

* Ubuntu Focal Fossa 20.04
* ROS2 Foxy Fitzroy
* ...

## Installation

To get started, follow these steps:

### 1 Install docker
Install and configure [Docker](https://www.docker.com/get-started) for your operating system.

##### Windows

1. Install [Docker Desktop for Windows/Mac](https://www.docker.com/products/docker-desktop).

2. Right-click on the Docker task bar item, select **Settings/Preferences** and update **Resources > File Sharing** with any locations your source code is kept. See [tips and tricks](https://code.visualstudio.com/docs/remote/troubleshooting#_container-tips) for troubleshooting.

3. If you are using WSL 2 on Windows, to enable the [Windows WSL 2 back-end](https://aka.ms/vscode-remote/containers/docker-wsl2): Right-click on the Docker taskbar item and select **Settings**. Check **Use the WSL 2 based engine** and verify your distribution is enabled under **Resources > WSL Integration**.

##### Linux

1. Follow the [official install instructions for Docker CE/EE for your distribution](https://docs.docker.com/install/#supported-platforms). If you are using Docker Compose, follow the Docker Compose directions as well.

2. Add your user to the **docker** group by using a terminal to run: `sudo usermod -aG docker $USER`
```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```

3. Sign out and back in again so your changes take effect.

### 2 Install Visaul Studio code
1 - Install [Visual Studio Code](https://code.visualstudio.com/) or [Visual Studio Code Insiders](https://code.visualstudio.com/insiders/).

2 - Install the [Remote Development extension pack](https://aka.ms/vscode-remote/download/extension).

## Settings (recommended)

Complete the following steps to create a new container:

1. **Clone or Download the Github Repository to your local Machine**

    ```bash
    git clone https://github.com/Mailamaca/Maila_docker.git
    ```

1. **Customize some settings to reflect your needs (optional)**
    You can change some Environment Variables directly in the [Dockerfile](https://github.com/Mailamaca/Maila_docker/blob/master/Dockerfile):

1. **Build the Docker Image**

    ```bash
    cd /path/to/Maila_docker
    docker build -t <your-docker-image-name> .
    # e.g
    cd Maila_docker
    docker build -t maila-image .
    ```

    *Note: Please be sure to have enough disk space left. Building this image needs around 2GB of free space. The successfully built image has a size of 2GB*

1. **Create Docker Container**
   - `--name` sets the name of the container
   - `--h` sets the hostname of the container
   - `-it` sets it as interactable and using stdin and stdout
   - `--env DISPLAY=$DISPLAY` sets an environment var for GUI
   - `-v /tmp/.X11-unix:/tmp/.X11-unix` sets a volume to share the x server
   - `-p` sets a port forwarding

    ``` bash
    docker create -it --name maila-container -h maila -v /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY -p 2222:22 maila-image
    ```

1. **Start/Stop of Docker Container**

    ```bash
    docker start -ia <your-docker-container-name>
    docker stop <your-docker-container-name>
    # e.g
    docker start -ia maila-container
    docker stop maila-container
    ```

1. **Open a new terminal connected to the container (AS USER)**

    ``` bash
    docker exec -it maila-container bash
    ```

1. **Open a new terminal connected to the container (AS ROOT)**

    ``` bash
    docker exec -u 0 -it maila-container bash
    ```




### SSH

**TODO**

To access the Docker Container via SSH: ```ssh root@localhost -p 2222```

User | Password
-------- | -----
root | oracle
oracle | oracle



## Docker useful commands

#### Remove container

1. Get all containers

   ``` bash
   docker ps -a
   ```

2. Delete ones

   ``` bash
   docker rm maila
   ```

#### Remove docker image

1. Get all images

   ``` bash
   docker images
   ```

2. Delete ones

   ``` bash
   docker rmi 27aba35ee129
   ```

#### Backup container state (NOT THE DATA VOLUME)

1. Create a backup of the container to an image. 

   ``` bash
   docker commit -p maila maila/backup:20200720
   ```

   Kindly note that this will not cover the data volume. You need to take the backup of data-volume (if any) separately. To know this data-directory (data volume location) of a container, use the command `docker inspect container-name`. You will get a section called “Mounts”. Location mentioned in “Source” is the data volume. You may directly backup this folder(here /site) to get backup of data volume.

2. Save image as a tar file

   ``` bash
   docker save -o maila_backup_20200720.tar maila/backup:20200720
   ```

#### Restore container backup (NOT THE DATA VOLUME)

1. Image can be extracted from backup tar file using the following command

   ``` bash
   docker load -i /tmp/backup01.tar
   ```

2. You can create container from this image using “docker create“. If you had data volume on the original container. You must restore the data volume too and run container with the data volume (docker create -v)



#### Check the version of Docker installed on your machine

<code>    <span class="nv">$ </span>docker --version<span class="nt">--all</span> </code>

####  Download and start a session with ROS2 foxy docker container

<code>    <span class="nv">$ </span>docker run -it ros:foxy <span class="nt">--all</span> </code>

####  List of the images downloaded to your machine

<code>    <span class="nv">$ </span>docker image ls <span class="nt">--all</span>

    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    ros                 foxy                4273086f549d        13 days ago         722MB
</code>

####  run a docker image

<code>    <span class="nv">$ </span>docker run <image ID> <span class="nt">--all</span> </code>

####  List all containers (spawned by the image) that exit after displaying its message.

If it is still running, you do not need the **--all** option

<code>    <span class="nv">$ </span>docker ps --all <span class="nt">--all</span>

    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS               NAMES
    9867db35d3fe        4273086f549d        "/ros_entrypoint.sh …"   8 minutes ago       Exited (0) 8 minutes ago                       priceless_goldberg
    42f7c2645a99        ros:foxy            "/ros_entrypoint.sh …"   16 minutes ago      Up 15 minutes                                  competent_feynman
</code>

## ROS2 turtlesim example

``` bash
source /opt/ros/foxy/setup.bash
printenv | grep -i ROS
apt update
apt install ros-foxy-turtlesim
ros2 pkg executables turtlesim
ros2 run turtlesim turtlesim_node
ros2 run turtlesim turtle_teleop_key
```

## Credits
This Dockerfile is based on the following work:

-  Daniel Hochleitner's GitHub Project [ Dani3lSun/docker-db-apex-dev](https://github.com/Dani3lSun/docker-db-apex-dev)

## License

MIT

See [Oracle Database Licensing Information User Manual](https://docs.oracle.com/database/122/DBLIC/Licensing-Information.htm#DBLIC-GUID-B6113390-9586-46D7-9008-DCC9EDA45AB4) regarding Oracle Database licenses.
