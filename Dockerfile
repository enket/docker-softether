# SoftEther VPN server

FROM ubuntu:14.04
MAINTAINER enket <tr.0224@gmail.com>

ENV VERSION v4.19-9605-beta-2065.03.06
WORKDIR /usr/local/vpnserver


RUN apt-get update &&\
        apt-get -y -q install gcc make && \
        apt-get clean && \
        rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
        wget http://www.softether-download.com/files/softether/${VERSION}-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-${VERSION}-linux-x64-64bit.tar.gz -O /tmp/softether-vpnserver.tar.gz &&\
        tar -xzvf /tmp/softether-vpnserver.tar.gz -C /usr/local/ &&\
        rm /tmp/softether-vpnserver.tar.gz &&\
        make i_read_and_agree_the_license_agreement &&\
        apt-get purge -y -q --auto-remove gcc make

ADD vpnserver.init.d /etc/init.d/vpnserver
RUN chmod 755 /etc/init.d/vpnserver
RUN update-rc.d vpnserver defaults 99
RUN service vpnserver start