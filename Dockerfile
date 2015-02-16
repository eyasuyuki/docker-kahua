FROM ubuntu:14.10
MAINTAINER ENDO Yasuyuki <eyasuyuki@gmail.com>

RUN apt-get update -y
RUN apt-get install -y wget gcc git
RUN apt-get install -y zlib1g-dev slib
RUN apt-get install -y make autoconf

WORKDIR /tmp
RUN wget http://downloads.sourceforge.net/gauche/Gauche-0.9.4.tgz
RUN tar xvfz Gauche-0.9.4.tgz

WORKDIR Gauche-0.9.4
RUN ./configure
RUN make
RUN make check
RUN make install

WORKDIR /tmp
RUN git clone https://github.com/kahua/Kahua.git

WORKDIR Kahua
RUN ./DIST gen
RUN ./configure
RUN make
RUN make check
RUN make install
ADD kahua.conf /usr/local/etc/kahua/kahua.conf

WORKDIR /work
RUN kahua-package create site
RUN kahua-package generate hello

WORKDIR hello
RUN ./DIST gen
RUN ./configure --with-site-bundle=/work/site
RUN make
RUN make check
RUN make install

EXPOSE 8888
ENTRYPOINT kahua-spvr -S /work/site -H 127.0.0.1:8888
