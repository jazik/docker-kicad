ARG UBUNTU_VER=19.04
FROM ubuntu:${UBUNTU_VER}
MAINTAINER Seppe Stas <seppe@productize.be>
LABEL Description="Minimal KiCad image based on Ubuntu"

ARG USER=kicaduser
ARG USER_ID=1000
ARG USER_GID=1000
ENV USER=${USER}
ENV USER_ID=${USER_ID}
ENV USER_GID=${USER_GID}

ARG KICAD_REL=5.1
ARG KICAD_VER=
ENV KICAD_REL=${KICAD_REL}
ENV KICAD_VER=${KICAD_VER}

ADD kicad-ppa.pgp .
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
	apt-get -y update && \
	apt-get -y install gnupg2 passwd sudo && \
	echo "deb http://ppa.launchpad.net/js-reynaud/kicad-${KICAD_REL}/ubuntu disco main" >> /etc/apt/sources.list && \
	apt-key add kicad-ppa.pgp && \
	apt-get -y update && apt-get -y install --no-install-recommends kicad${KICAD_VER} && \
	useradd -m -u ${USER_ID} ${USER} && \
	passwd -d ${USER} && \
	echo "${USER} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USER} && \
	chmod 0440 /etc/sudoers.d/${USER} && \
	chown -R ${USER}:${USER} /home/${USER} && \
	apt-get -y purge gnupg2 && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/* && \
	rm kicad-ppa.pgp

USER ${USER}
ENV HOME=/home/${USER}
WORKDIR $HOME
ENTRYPOINT kicad
