# Docker -  Development Environment

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)
[![Open Source Love png2](https://badges.frapsoft.com/os/v2/open-source.png?v=103)](https://github.com/ellerbrock/open-source-badges/)

To ensure a common, consistent development environment we develop a docker image to run all the packages required from the *Maila* project.

## Content
This Docker Image contains the following:

* ROS2 Foxy Fitzroy
* ...

## Installation

### Intalling docker

1. Install docker from apt

```bash
sudo apt update
sudo apt install docker.io
```

2. Enable docker service

```bash
sudo systemctl enable docker
```

3. Reboot or start manually docker

```bash
sudo systemctl start docker
```

4. Create a docker group and append the current user to avoid use sudo when runnin docker cmds

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```

### Using Default Settings (recommended)

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

-  Daniel Hochleitner's GitHub Project [ Dani3lSun/docker-db-apex-dev](https://github.com/Dani3lSun/docker-db-apex-dev/blob/master/README.md)

## License

MIT

See [Oracle Database Licensing Information User Manual](https://docs.oracle.com/database/122/DBLIC/Licensing-Information.htm#DBLIC-GUID-B6113390-9586-46D7-9008-DCC9EDA45AB4) regarding Oracle Database licenses.