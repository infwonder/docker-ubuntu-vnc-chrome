# Docker-Ubuntu-Vnc-Chrome

This is a Dockerfile that runs Ubuntu Destop with Google Chrome and vncserver pre-installed.
### Note: this document assumes host system is CentOS 7.

# Usage:
     docker run -it -e USER="jasonlin" \
       --cap-add=SYS_ADMIN \
       --shm-size=4gb --memory=4gb \
       --device /dev/snd \
       -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
	  -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native \
	  --group-add $(getent group audio | cut -d: -f3) \
       --name chrome-vnc \
       --entrypoint="/bin/bash" \
       -v /home/jasonlin/tmp:/data:z <image_id>

After entering the container, run something like:

     vncserver :1 -geometry 1440x960 -depth 24

to start vncserver.

Leave the container bash shell open, and connect to vncserver via vncviewer on host:

     vncview <container_ip>:5901

Where container_ip can be found using:

     docker inspect <container_id>

Where container_id can be found using:

     docker ps
