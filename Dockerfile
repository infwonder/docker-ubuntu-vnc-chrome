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
  apt-get install -y apt-utils wget openssh-server \
  xfce4 xfce4-goodies x11vnc xvfb \
  gconf-service libnspr4 libnss3 fonts-liberation \
  libappindicator1 libcurl3 fonts-wqy-microhei tightvncserver && \
  mkdir -p /var/run/sshd && \
  sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
  sed -ri 's/#Port 22/Port 5800/g' /etc/ssh/sshd_config && \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update -y && \
  apt-get install -y google-chrome-stable && \
  rm -rf /var/lib/apt/lists/* && \
  groupadd -g 1000 jasonlin && \
  useradd -u 1000 -g 1000 -m -d /data jasonlin 

USER root

VOLUME /data

# Define working directory.
WORKDIR /data

# Define default command.
ENTRYPOINT ["/bin/bash"]
