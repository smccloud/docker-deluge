FROM centos:7
ENV container docker
MAINTAINER smccloud

# Parts of this Docker file and scripts were used from binhex/arch-deluge in order to get Deluge 1.3.11 for IP Torrents

# Install EPEL
RUN yum -y install epel-release

# Update system
RUN yum -y update

# Install Nux Desktop Repo
RUN rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
RUN rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm

# Install Deluge Web 1.3.11
RUN yum -y install deluge-web-1.3.11

# Clean Yum stuff
RUN yum clean all

# Expose WebUI port
EXPOSE 8112

# Expose daemon port
EXPOSE 58846

# Expose TCP & UDP ports for torrent data
EXPOSE 58946
EXPOSE 58946/udp

# Map /config to host defined config path (used to store configuration from app)
VOLUME /config

# Map /data to host defined data path (used to store data from app)
VOLUME /data

# Add pre-configured config files for nobody
ADD config/nobody/ /home/nobody/

# Set environment variables for user nobody
ENV HOME /home/nobody

# Run script to set uid, gid and permissions
CMD ["/usr/sbin/init"]