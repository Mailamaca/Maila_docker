# Docker -  Development Environment

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)
[![Open Source Love png2](https://badges.frapsoft.com/os/v2/open-source.png?v=103)](https://github.com/ellerbrock/open-source-badges/)

To ensure a common, consistent development environment we develop a docker image to run all the packages required from the *Maila* project.

The requirement for this  is to install docker, please follow: https://www.docker.com/get-started.

## Content
This Docker Image contains the following:

* ROS2 Foxy Fitzroy
* ...

## Installation

### Using Default Settings (recommended)

Complete the following steps to create a new container:

1. **Clone or Download the Github Repository to your local Machine**

```bash
git clone https://github.com/Mailamaca/Maila_docker.git
```


2) asdfa

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
