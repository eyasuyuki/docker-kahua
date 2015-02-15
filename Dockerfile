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
RUN wget http://www.kahua.org/download/kahua/Kahua-1.0.7.3.tgz
RUN tar xvfz Kahua-1.0.7.3.tgz

WORKDIR Kahua-1.0.7.3
RUN ./configure
RUN make
RUN make check
RUN make install

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
