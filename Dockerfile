FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y wget git build-essential libxml2 libxml2-dev libxml2-utils zip
WORKDIR /
RUN wget https://github.com/devkitPro/pacman/releases/download/devkitpro-pacman-1.0.1/devkitpro-pacman.deb
RUN dpkg -i devkitpro-pacman.deb
RUN dkp-pacman -S --noconfirm switch-dev switch-libjpeg-turbo devkitARM devkitarm-rules
RUN rm devkitpro-pacman.deb
ENV DEVKITPRO=/opt/devkitpro
ENV DEVKITARM=/opt/devkitpro/devkitARM 
RUN git clone https://github.com/switchbrew/libnx
WORKDIR /libnx
RUN make
RUN make install
WORKDIR /
RUN apt install -y python3 python3-pip
RUN ln -s /usr/bin/python3 /usr/local/bin/python
RUN pip3 install pycryptodome
