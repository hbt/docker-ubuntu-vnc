FROM ubuntu:18.04
MAINTAINER Marco Pantaleoni <marco.pantaleoni@gmail.com>

RUN echo "Europe/Rome" > /etc/timezone
# RUN sudo ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime

RUN apt-get update -q && \
	export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends tzdata

RUN dpkg-reconfigure -f noninteractive tzdata

# Install packages
RUN apt-get update -q && \
	export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends wget curl rsync netcat mg vim bzip2 zip unzip && \
    apt-get install -y --no-install-recommends libx11-6 libxcb1 libxau6 && \
    apt-get install -y --no-install-recommends lxde tightvncserver xvfb dbus-x11 x11-utils && \
    apt-get install -y --no-install-recommends xfonts-base xfonts-75dpi xfonts-100dpi && \
    apt-get install -y --no-install-recommends python-pip python-dev python-qt4 && \
    apt-get install -y --no-install-recommends libssl-dev && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root/

RUN mkdir -p /root/.vnc
COPY xstartup /root/.vnc/
RUN chmod a+x /root/.vnc/xstartup
RUN touch /root/.vnc/passwd
RUN /bin/bash -c "echo -e 'password\npassword\nn' | vncpasswd" > /root/.vnc/passwd
RUN chmod 400 /root/.vnc/passwd
RUN chmod go-rwx /root/.vnc
RUN touch /root/.Xauthority


RUN apt-get update && apt-get install -y sudo curl gnupg
RUN /bin/bash -c "$(curl -sL https://git.io/vokNn)"
#RUN apt-fast install -y calibre
RUN apt-get update && apt-fast install -y xdotool
RUN apt-get update && apt-fast install -y gdb
#RUN apt-get update && apt-fast install -y tigervnc-standalone-server
RUN apt-get remove -y tightvncserver
RUN wget "http://tigervnc.bphinz.com/nightly/ubuntu-18.04LTS/amd64/tigervncserver_1.11.80+20200914gite6f910a0-1ubuntu1_amd64.deb"
RUN dpkg -i tigervncserver_1.11.80+20200914gite6f910a0-1ubuntu1_amd64.deb  || true
RUN apt-get install -fy


RUN echo "mycontainer" > /etc/hostname && echo "127.0.0.1	localhost" > /etc/hosts && echo "127.0.0.1	mycontainer" >> /etc/hosts
ENV PATH $PATH:/vncubuntu/scripts

COPY start-vncserver.sh /root/
RUN chmod a+x /root/start-vncserver.sh

COPY xstartup2 /root/.vnc/
RUN mv /root/.vnc/xstartup2 /root/.vnc/xstartup

EXPOSE 5901
ENV USER root
CMD [ "/root/start-vncserver.sh" ]
