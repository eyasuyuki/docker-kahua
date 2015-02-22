FROM nkoguro/gauche:stable
MAINTAINER ENDO Yasuyuki <eyasuyuki@gmail.com>

RUN apt-get install -y wget git

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
RUN kahua-package generate -creator=Kahua -mail=info@kahua.org hello

WORKDIR hello
RUN ./DIST gen
RUN ./configure --with-site-bundle=/work/site
RUN make
#RUN make check
RUN make install
ADD app-servers /work/site/app-servers

CMD kahua-spvr -S /work/site -H 127.0.0.1:8888

EXPOSE 8888
