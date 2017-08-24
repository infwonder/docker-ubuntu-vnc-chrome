# Docker-Ubuntu-Vnc-Chrome

This is a Dockerfile that runs Ubuntu Destop with Google Chrome and vncserver pre-installed.

# Usage:
     docker run -it -e USER="jasonlin" \
       --cap-add=SYS_ADMIN \
       --shm-size=4gb --memory=4gb \
       --device /dev/snd \
       --name chrome-vnc \
       --entrypoint="/bin/bash" \
       -v /home/jasonlin/tmp:/data <image_id>

After entering the container, run something like:

     vncserver :1 -geometry 1440x960 -depth 24

to start vncserver.

Leave the container bash shell open, and connect to vncserver via vncviewer on host:

     vncview <container_ip>:5901

Where container_ip can be found using:

     docker inspect <container_id>

Where container_id can be found using:

     docker ps
