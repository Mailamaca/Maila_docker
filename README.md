# Maila Project Dockerfiles

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/4eaea9585d914f7baff0397e2bedeb44)](https://app.codacy.com/gh/Mailamaca/Maila_docker?utm_source=github.com&utm_medium=referral&utm_content=Mailamaca/Maila_docker&utm_campaign=Badge_Grade)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)
[![Open Source Love png2](https://badges.frapsoft.com/os/v2/open-source.png?v=103)](https://github.com/ellerbrock/open-source-badges/)

To ensure a common, consistent development environment few docker images were created to run all the packages required from the *Maila* project.

## Table of Content

[TOC]

## Docker images

This repository contain the definition of the following Docker images:

* ***maila-base*** image containing of the core module avoiding heavy visual tool application and physics simulator
* ***mailla-dev*** image containing the complete set of tools needed to develop application within the Maila project

## Requirements

1. [Install Docker](https://github.com/ignitionrobotics/ign-gazebo/blob/ign-gazebo4/docker/README.md#Install-Docker)

## Working with docker images

**Build the images:** *Note: Please be sure to have enough disk space left. Building this image needs around 2GB of free space. The successfully built image has a size of 2GB*

```sh
make build_maila_base  # build only maila-base img
make build_maila_dev  # build only maila-dev img
make build  # build both
```

**Pushing images on dockerhub:** 

- Log into the Docker Hub from the command line

  ```sh
  docker login --username=yourhubusername
  ```

- Push the images on dockerhub

  ```sh
  make push_maila_base  # push only maila-base img
  make push_maila_dev  # push only maila-dev img
  make push  # push both
  ```

**Pulling images from dockerhub:**

```sh
make pull_maila_base  # pull only maila-base img
make pull_maila_dev  # pull only maila-dev img
make pull  # pull both
```

## Run the containers

Once the images are downloaded on your local machine we can run the containers as user with:

```shell
 export IMAGE_NAME=maila/maila-dev
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

1. Start the ssh service on the running container. `sudo service ssh start`
2. Connect from an external terminal:
   - connect using port 2222 of the host machine, since the container port 22 is published on the host port 2222  (`docker run .... -p 2222:22`)
     - `ssh root@localhost -p 2222` connect as root 
     - `ssh snail@localhost -p 2222` connect as user
   - connect directly to the port 22 of the container. To get the IP of the running container`sudo docker inspect -f "{{ .NetworkSettings.IPAddress }}" maila-container`
     - `ssh root@<container_ip>` connect as root 
     - `ssh snail@<container_ip>` connect as user

**Note:** if the Host identification has change try `ssh-keygen -f "/home/ubuntu/.ssh/known_hosts" -R "[localhost]:2222"`

### Access Credentials

| User  | Password |
| ----- | -------- |
| root  | root     |
| snail | snail    |

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
* [Ignition Gazebo Dockerfiles](https://github.com/ignitionrobotics/ign-gazebo/blob/ign-gazebo4/docker/README.md) 

## Appendix

### Install docker

Install and configure [Docker](https://www.docker.com/get-started) for your operating system.

#### Linux

Docker has two available versions: Community Edition (CE) and  Enterprise Edition (EE). In this tutorial, we'll install the CE version.

1. Remove old versions of Docker (if installed):

   ```
   sudo apt-get remove docker docker-engine docker.io
   ```

2. Install dependencies and keys.

   ```
    sudo apt install curl apt-transport-https ca-certificates curl software-properties-common
   
    # Add the official GPG key of Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   ```

3. Setup Docker using 1 of the two options below.

   1. Ubuntu Bionic users

      ```
       sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) edge"
      ```

   2. Everyone else.

      ```
       sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
      ```

4. Install Docker

   ```
    sudo apt-get update && sudo apt-get install docker-ce
   ```

5. Check your Docker installation:

   ```
    sudo docker run hello-world
   ```

6. You should see the message `Hello from Docker!` confirming that your installation was successfully completed.

#### Windows

1. Install [Docker Desktop for Windows/Mac](https://www.docker.com/products/docker-desktop).
2. Right-click on the Docker task bar item, select **Settings/Preferences** and update **Resources > File Sharing** with any locations your source code is kept. See [tips and tricks](https://code.visualstudio.com/docs/remote/troubleshooting#_container-tips) for troubleshooting.
3. If you are using WSL 2 on Windows, to enable the [Windows WSL 2 back-end](https://aka.ms/vscode-remote/containers/docker-wsl2): Right-click on the Docker taskbar item and select **Settings**. Check **Use the WSL 2 based engine** and verify your distribution is enabled under **Resources > WSL Integration**.

## License

MIT

See [Oracle Database Licensing Information User Manual](https://docs.oracle.com/database/122/DBLIC/Licensing-Information.htm#DBLIC-GUID-B6113390-9586-46D7-9008-DCC9EDA45AB4) regarding Oracle Database licenses.
