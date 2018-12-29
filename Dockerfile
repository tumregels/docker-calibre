FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y apt-utils software-properties-common sudo

RUN add-apt-repository -y ppa:jonathonf/calibre; exit 0

RUN apt-get update && apt-get install -y --no-install-recommends calibre

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/docker && \
    echo "docker:x:${uid}:${gid}:Docker,,,:/home/docker:/bin/bash" >> /etc/passwd && \
    echo "docker:x:${uid}:" >> /etc/group && \
    echo "docker ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/docker && \
    chmod 0440 /etc/sudoers.d/docker && \
    chown ${uid}:${gid} -R /home/docker

USER docker
