#!/bin/bash

echo "......Checking Scripts......"
if [ ! -f /scripts/entrypoint.sh ]; then
    echo "/scripts/entrypoint.sh not found!"
    exit 1
fi
if [ ! -f /scripts/image_setup.sh ]; then
    echo "/scripts/image_setup.sh not found!"
    exit 1
fi
if [ ! -f /scripts/install_main.sh ]; then
    echo "/scripts/install_main.sh not found!"
    exit 1
fi
if [ ! -f /scripts/install_ros.sh ]; then
    echo "/scripts/install_ros.sh not found!"
    exit 1
fi
if [ ! -f /scripts/install_ssh.sh ]; then
    echo "/scripts/install_ssh.sh not found!"
    exit 1
fi
if [ ! -f /scripts/validations.sh ]; then
    echo "/scripts/validations.sh not found!"
    exit 1
fi
#
echo "......Checking Files......"
if [ ! -f /files/db_install_12.rsp ]; then
    echo "/files/db_install_12.rsp not found!"
    exit 1
fi
if [ ! -f /files/db_install_18.rsp ]; then
    echo "/files/db_install_18.rsp not found!"
    exit 1
fi
if [ ! -f /files/db_install_19.rsp ]; then
    echo "/files/db_install_19.rsp not found!"
    exit 1
fi
if [ ! -f /files/ords_params.properties ]; then
    echo "/files/ords_params.properties not found!"
    exit 1
fi
if [ ! -f /files/tomcat-users.xml ]; then
    echo "/files/tomcat-users.xml not found!"
    exit 1
fi
if [ ! -f /files/tomcat.service ]; then
    echo "/files/tomcat.service not found!"
    exit 1
fi
#
echo "......Checking Downloaded Files......"
if [ ${EXAMPLE_CHECK} == "True" ]; then
    if ! ls /files/fake_file.zip 1> /dev/null 2>&1; then
        echo "Fake file not found!"
        exit 1
    fi
fi
#
echo "......Validations Done......"
