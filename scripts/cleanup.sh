#!/bin/bash
#set -x #echo on

# cleanup
echo "--------------------------------------------------"
echo "Cleanup..........................................."
apt-get clean all
rm -r -f /tmp/*
rm -r -f /files/*
rm -r -f /var/tmp/*
rm -r -f /var/lib/apt/lists/*
echo "--------------------------------------------------"
echo "DONE.............................................."
