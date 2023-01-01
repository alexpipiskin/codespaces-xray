FROM --platform=${TARGETPLATFORM} ubuntu:focal

ENV SHELL=/bin/bash

WORKDIR /root
ARG TARGETPLATFORM
ARG TAG
COPY xray.sh /root/xray.sh

RUN apt-get update &&
    apt-get upgrade -y &&
    apt-get install -y tzdata openssl ca-certificates &&
    mkdir -p /usr/local/etc/xray /usr/local/share/xray /var/log/xray &&
    chmod +x /root/xray.sh &&
    /root/xray.sh "${TARGETPLATFORM}" "${TAG}"

COPY config.json /usr/local/etc/xray/config.json

RUN apt-get -y install nginx

COPY xray.conf /etc/nginx/default.d/xray.conf

ENTRYPOINT ["/usr/local/bin/xray"]
