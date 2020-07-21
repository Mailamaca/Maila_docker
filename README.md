# Docker -  Development Environment

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)
[![Open Source Love png2](https://badges.frapsoft.com/os/v2/open-source.png?v=103)](https://github.com/ellerbrock/open-source-badges/)

To ensure a common, consistent development environment we develop a docker image to run all the packages required from the *Maila* project.

## Content

This Docker Image contains the following:

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

2. **Customize some settings to reflect your needs (optional)**
You can change some Environment Variables directly in the [Dockerfile](https://github.com/Mailamaca/Maila_docker/blob/master/Dockerfile):

3. **Build the Docker Image**

```bash
cd /path/to/Maila_docker
docker build -t <your-docker-image-name> .
# e.g
docker build -t maila-image .
```

*Note: Please be sure to have enough disk space left. Building this image needs around xxxGB of free space. The successfully built image has a size of xxxGB*

5. **Run the Docker Container**

```bash
docker run -d --name <your-docker-container-name> -p 2222:22 -p 8080:8080 -p 1521:1521 <your-docker-image-name>
# e.g
docker run -d --name maila-container -p 2222:22 -p 8080:8080 -p 1521:1521 maila-image
```

6. **Start/Stop of Docker Container**

```bash
docker start -ia <your-docker-container-name>
docker stop <your-docker-container-name>
# e.g
docker start -ia maila-container
docker stop maila-container
```

## Access To Services
**docker run -d --name db-apex-dev-container -p 2222:22 -p 8080:8080 -p 1521:1521 -v /dev/shm --tmpfs /dev/shm:rw,nosuid,nodev,exec,size=2g db-apex-dev-image**


### SSH

To access the Docker Container via SSH: ```ssh root@localhost -p 2222```

User | Password
-------- | -----
root | oracle
oracle | oracle

**TODO: fixx table!**

## Docker useful commands

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

#### Stop a running istance:
<code>    <span class="nv">$ </span>docker stop competent_feynman<span class="nt">--all</span>
competent_feynman
</code>

## Credits
This Dockerfile is based on the following work:

-  Daniel Hochleitner's GitHub Project [ Dani3lSun/docker-db-apex-dev](https://github.com/Dani3lSun/docker-db-apex-dev)

## License

MIT

See [Oracle Database Licensing Information User Manual](https://docs.oracle.com/database/122/DBLIC/Licensing-Information.htm#DBLIC-GUID-B6113390-9586-46D7-9008-DCC9EDA45AB4) regarding Oracle Database licenses.
