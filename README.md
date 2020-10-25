# Docker -  Development Environment

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/4eaea9585d914f7baff0397e2bedeb44)](https://app.codacy.com/gh/Mailamaca/Maila_docker?utm_source=github.com&utm_medium=referral&utm_content=Mailamaca/Maila_docker&utm_campaign=Badge_Grade)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)
[![Open Source Love png2](https://badges.frapsoft.com/os/v2/open-source.png?v=103)](https://github.com/ellerbrock/open-source-badges/)

To ensure a common, consistent development environment we develop a docker image to run all the packages required from the *Maila* project.

## Content

This Docker Image contains the following:

* ***maila-base*** image containing of the core module avoiding heavy visual tool application and physics simulator
* ***mailla-dev*** image containing the complete set of tools needed to develop application within the Maila project
* ***coming soon***

## Prerequisites

### 1 Install docker

Install and configure [Docker](https://www.docker.com/get-started) for your operating system.

#### Windows

1. Install [Docker Desktop for Windows/Mac](https://www.docker.com/products/docker-desktop).

2. Right-click on the Docker task bar item, select **Settings/Preferences** and update **Resources > File Sharing** with any locations your source code is kept. See [tips and tricks](https://code.visualstudio.com/docs/remote/troubleshooting#_container-tips) for troubleshooting.

3. If you are using WSL 2 on Windows, to enable the [Windows WSL 2 back-end](https://aka.ms/vscode-remote/containers/docker-wsl2): Right-click on the Docker taskbar item and select **Settings**. Check **Use the WSL 2 based engine** and verify your distribution is enabled under **Resources > WSL Integration**.

#### Linux

1. Follow the [official install instructions for Docker CE/EE for your distribution](https://docs.docker.com/install/#supported-platforms). If you are using Docker Compose, follow the Docker Compose directions as well.

2. Add your user to the **docker** group by using a terminal to run: `sudo usermod -aG docker $USER`

   ```shell
   sudo groupadd docker
   sudo usermod -aG docker $USER
   ```

3. Sign out and back in again so your changes take effect.

## Get the images

There are 2 ways of getting the running Docker images. The fastest approach is to directly download from Docker Hub the images. The second approach require to download the repository and build the images.

### From Docker Hub

The simpler way to get the Docker images is from Docker Hub.

- `docker pull maila/maila-dev:latest` download the maila-dev image
- `docker pull maila/maila-base:latest`download the maila-base image

### Building the Docker images

1. **Clone** or Download the Github Repository to your local Machine

    ```bash
    git clone https://github.com/Mailamaca/Maila_docker.git
    ```

2. **Build the Docker Image**

    ```bash
    cd /path/to/Maila_docker
    # Build maila-base
    cd maila-base/
    docker build -t maila-base .
    
    # Build maila-base
    cd ../maila-dev/
    docker build -t maila-dev .
    ```

    *Note: Please be sure to have enough disk space left. Building this image needs around 2GB of free space. The successfully built image has a size of 2GB*

## Run the containers

Once the images are downloaded on your local machine we can run the containers as user with:

```shell
 export IMAGE_NAME=maila-dev
 docker run --rm -it \
     --name maila-container -h maila \
     --user "$(id -u):$(id -g)" \
     --mount type=bind,src="$PWD"/../,dst=/mailamaca \
     -v /tmp/.X11-unix:/tmp/.X11-unix \
     --env DISPLAY=$DISPLAY \
     -p 2222:22 \
     ${IMAGE_NAME}
```

### Connecting from a terminal

Having a running image it is possible to connect multiple terminal to the running instance:

- `docker exec -it maila-container bash` to connect to the container as user
- `docker exec -u 0 -it maila-container bash` to connect to the container as root

### Connecting using ssh

- `ssh root@localhost -p 2222` connect as root 
- `ssh snail@localhost -p 2222` connect as user

**Note:** if the Host identification has change try `ssh-keygen -f "/home/ubuntu/.ssh/known_hosts" -R "[localhost]:2222"`



## Simple ROS2 working example

In order to check if the maila-dev container is working properly you could try to run the following code. If you are able to control the turtle with your keyboard the system is working properly.

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

* Daniel Hochleitner's GitHub Project [ Dani3lSun/docker-db-apex-dev](https://github.com/Dani3lSun/docker-db-apex-dev)

* https://tuw-cpsg.github.io/tutorials/docker-ros/

## License

MIT

See [Oracle Database Licensing Information User Manual](https://docs.oracle.com/database/122/DBLIC/Licensing-Information.htm#DBLIC-GUID-B6113390-9586-46D7-9008-DCC9EDA45AB4) regarding Oracle Database licenses.
