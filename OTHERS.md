# TODO

Information not updated after image changes

## Connecting using ssh

  1. Start the ssh service on the running container. `sudo service ssh start`
  2. Connect from an external terminal:
     - connect using port 2222 of the host machine, since the container port 22 is published on the host port 2222 (`docker run .... -p 2222:22`)
       - `ssh root@localhost -p 2222` connect as root
       - `ssh snail@localhost -p 2222` connect as user
     - connect directly to the port 22 of the container. To get the IP of the running container`sudo docker inspect -f   "{{ .NetworkSettings.IPAddress }}" maila-container`
       - `ssh root@<container_ip>` connect as root
       - `ssh snail@<container_ip>` connect as user

**Note:** if the Host identification has change try `ssh-keygen -f "/home/ubuntu/.ssh/known_hosts" -R "[localhost]:2222"`

## Access Credentials

| User  | Password |
| ----- | -------- |
| root  | root     |
| snail | snail    |
