#!/bin/bash

if ZA_USESSH; then

    # install openssh
    apt-get update
    apt-get install -y openssh-server
    mkdir /var/run/sshd

    # SSH login fix. Otherwise user is kicked off after login
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

    # set authorized_keys file root
    mkdir /root/.ssh/
    apt-get clean
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

fi
