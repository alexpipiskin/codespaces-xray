FROM nginx:latest

ARG TARGETPLATFORM
ARG TAG

COPY xray.conf /etc/nginx/conf.d/default.conf
COPY xray.sh /root/xray.sh

WORKDIR /root

RUN LANG="C.UTF-8" \
    && apt-get update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    curl \
    wget \
    unzip \
    tzdata \
    openssl \
    ca-certificates \
    && mkdir -p /usr/local/etc/xray /usr/local/share/xray /var/log/xray \
    && chmod +x /root/xray.sh \
    && /root/xray.sh "${TARGETPLATFORM}" "${TAG}"

COPY config.json /usr/local/etc/xray/config.json

CMD ["/usr/local/bin/xray", "-c", "/usr/local/etc/xray/config.json"]
