#!/bin/bash

echo "--------------------------------------------------"
echo "Environment Vars.................................."
echo "TIME_ZONE: ${TIME_ZONE}"
echo "TMP_REMOVE_ME_TEST: ${TMP_REMOVE_ME_TEST}"
#
#
echo "--------------------------------------------------"
echo "Validations......................................."
./scripts/validations.sh || exit 1
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
echo "Installing ROS PKGS..............................."
./scripts/install_ros.sh
#
echo "--------------------------------------------------"
echo "Cleanup..........................................."
yum clean all
rm -r -f /tmp/*
rm -r -f /files/*
rm -r -f /var/tmp/*
rm -r -f /var/lib/apt/lists/*
echo "--------------------------------------------------"
echo "DONE.............................................."
