FROM alpine:latest

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Sunnybase thanks to Dominic Taylor <dominic@yobasystems.co.uk>" \
    architecture="amd64/x86_64" \
    mariadb-version="10.4.12" \
    alpine-version="latest" \
    build="20-Feb-2020" \
    org.opencontainers.image.title="alpine-mariadb" \
    org.opencontainers.image.description="MariaDB Docker image running on Alpine Linux" \
    org.opencontainers.image.authors="Dominic Taylor <dominic@yobasystems.co.uk>" \
    org.opencontainers.image.vendor="Yoba Systems" \
    org.opencontainers.image.version="v10.4.12" \
    org.opencontainers.image.url="https://hub.docker.com/r/yobasystems/alpine-mariadb/" \
    org.opencontainers.image.source="https://github.com/yobasystems/alpine-mariadb" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE

RUN echo "https://mirror.leaseweb.com/alpine/latest-stable/main" > /etc/apk/repositories && \
	  echo "https://mirror.leaseweb.com/alpine/latest-stable/community" >>/etc/apk/repositories && \
    apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen && \
    rm -f /var/cache/apk/*

ADD files/run.sh /scripts/run.sh
RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]
