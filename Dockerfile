FROM php:7.4-apache

VOLUME /var/www/html

ENV RAINLOOP_VERSION 1.14.0

RUN set -ex; \
    fetchDeps="gnupg unzip"; \
    apt-get update; \
    apt-get install -y --no-install-recommends rsync $fetchDeps; \
    \
    curl -fsSL -o rainloop.zip https://github.com/RainLoop/rainloop-webmail/releases/download/v${RAINLOOP_VERSION}/rainloop-${RAINLOOP_VERSION}.zip; \
    curl -fsSL -o rainloop.zip.asc https://github.com/RainLoop/rainloop-webmail/releases/download/v${RAINLOOP_VERSION}/rainloop-${RAINLOOP_VERSION}.zip.asc; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys 3B797ECE694F3B7B70F311A4ED7C49D987DA4591; \
    gpg --batch --verify rainloop.zip.asc rainloop.zip; \
    unzip -q rainloop.zip -d /usr/src/rainloop; \
    gpgconf --kill all; \
    rm -r "$GNUPGHOME" rainloop.zip.asc rainloop.zip; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $fetchDeps; \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
