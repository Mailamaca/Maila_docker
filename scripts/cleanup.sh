#!/bin/bash

echo "--------------------------------------------------"
echo "Environment Vars.................................."
echo "TIME_ZONE: ${TIME_ZONE}"
echo "ZA_USESSH: ${ZA_USESSH}"
#
echo "--------------------------------------------------"
echo "Image Setup......................................."
./scripts/image_setup.sh
#
echo "--------------------------------------------------"
echo "Installing SSH...................................."
./scripts/install_ssh.sh
#
echo "--------------------------------------------------"
echo "Installing APT PKGS..............................."
./scripts/install_apt.sh
#
echo "--------------------------------------------------"
echo "Installing ROS PKGS..............................."
./scripts/install_ros.sh
#
echo "--------------------------------------------------"
echo "Cleanup..........................................."
apt-get clean all
rm -r -f /tmp/*
rm -r -f /files/*
rm -r -f /var/tmp/*
rm -r -f /var/lib/apt/lists/*
echo "--------------------------------------------------"
echo "DONE.............................................."
