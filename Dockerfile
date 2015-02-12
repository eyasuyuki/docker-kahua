FROM ubuntu:14.10

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

ENTRYPOINT gosh
