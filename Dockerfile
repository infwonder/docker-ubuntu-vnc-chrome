#
# Chrome Dockerfile
#
# https://github.com/dockerfile/chrome
#

# Pull base image.
FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

# Install Chromium.
RUN \
  apt-get update -y && \
  apt-get install -y wget \
  xfce4 xfce4-goodies x11vnc xvfb \
  gconf-service libnspr4 libnss3 fonts-liberation \
  libappindicator1 libcurl3 fonts-wqy-microhei tightvncserver && \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update -y && \
  apt-get install -y google-chrome-stable && \
  rm -rf /var/lib/apt/lists/* && \
  groupadd -g 1000 jasonlin && \
  useradd -u 1000 -g 1000 -m -d /data jasonlin 

USER jasonlin

VOLUME /data

# Define working directory.
WORKDIR /data

# Define default command.
ENTRYPOINT ["/bin/bash"]

# Expose ports.
EXPOSE 5901
