FROM ubuntu:14.04
MAINTAINER Kacey Cole <kcole@izeni.com>

RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends \
        lib32gcc1 \
        wget \
    > /dev/null && apt-get -qq clean -y && rm -rf /var/lib/apt/lists/*


# Set kernel tweaks
RUN echo "fs.file-max=100000" >> /etc/sysctl.conf
RUN sysctl -p /etc/sysctl.conf

RUN echo "*               soft    nofile          1000000" >> /etc/security/limits.conf
RUN echo "*               hard    nofile          1000000" >> /etc/security/limits.conf

RUN echo "session required pam_limits.so"


# Install steam-cli
RUN mkdir /steam /ark
WORKDIR /steam

RUN wget --no-check-certificate https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
RUN tar -xzvf steamcmd_linux.tar.gz

RUN /steam/steamcmd.sh +login anonymous +force_install_dir /ark +app_update "376030 validate" +quit

EXPOSE 7777/udp 27015/udp
