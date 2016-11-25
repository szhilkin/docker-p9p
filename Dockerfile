FROM buildpack-deps:jessie
MAINTAINER Sergey Zhilkin <szhilkin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN echo udev hold | dpkg --set-selections && \
    echo initscripts hold | dpkg --set-selections &&\
    echo upstart hold | dpkg --set-selections &&\
    apt-get update -q &&\
    apt-get -y upgrade

RUN apt-get -y install wget git unzip build-essential ca-certificates

ENV PLAN9=/usr/local/plan9 \
    PATH=${PATH}:${PLAN9}/bin \
    REPO=git://github.com/9fans/plan9port.git

WORKDIR ${PLAN9}

RUN git clone ${REPO} . &&\
    ./INSTALL

CMD /usr/local/plan9/bin/9 rc
