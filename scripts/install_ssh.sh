#!/bin/bash
#set -x #echo on

#if [ $ZA_USESSH != 0 ]; then

    # install openssh
    apt-get update && apt-get install -y \
    	openssh-server
    	
    mkdir /var/run/sshd
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    
    # SSH login fix. Otherwise user is kicked off after login
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
    
    #echo "export VISIBLE=now" >> /etc/profile
    
    
#else
#    echo "SSH NOT INSTALLED"
#fi
