ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:9.2.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN \
    apk add --no-cache \
        nginx=1.18.0-r15 \
        mariadb-client=10.5.10-r0 \
        php7-ctype=7.4.19-r0 \
        php7-curl=7.4.19-r0 \
        php7-fpm=7.4.19-r0 \
        php7-gettext=7.4.19-r0 \
        php7-json=7.4.19-r0 \
        php7-mbstring=7.4.19-r0 \
        php7-mysqli=7.4.19-r0 \
        php7-opcache=7.4.19-r00 \
        php7-session=7.4.19-r0 \
        php7-zip=7.4.19-r0 \
        php7=7.4.19-r0 \
    \
    && apk add --no-cache --virtual .build-dependencies \
        git=2.30.2-r0 \
    \
    && git clone --branch master \
        https://github.com/emoncms/emoncms.git /var/www/emoncms ; cd /var/www/emoncms ; git checkout 94a3f222cda2dcdf8a4b3ca6275108eca4549aec \
    && git clone --branch 2.0.10 --depth=1 \
        https://github.com/emoncms/dashboard.git /var/www/emoncms/Modules/dashboard \
    && git clone --branch 2.0.11 --depth=1 \
        https://github.com/emoncms/graph.git /var/www/emoncms/Modules/graph \
    && git clone --branch 2.2.7 --depth=1 \
        https://github.com/emoncms/app.git /var/www/emoncms/Modules/app \
    && git clone --branch 2.0.9 --depth=1 \
        https://github.com/emoncms/device.git /var/www/emoncms/Modules/device \
    \
    && apk del --no-cache --purge .build-dependencies \
    \
    && rm -f -r /var/www/emoncms/.git \
    && rm -f -r /var/www/emoncms/Modules/dashboard/.git \
    && rm -f -r /var/www/emoncms/Modules/graph/.git \
    && rm -f -r /var/www/emoncms/Modules/app/.git \
    && rm -f -r /var/www/emoncms/Modules/device/.git \
    && find /var/www/emoncms -type f -name ".htaccess" -depth -exec rm -f {} \; \
    && find /var/www/emoncms -type f -name "*.md" -depth -exec rm -f {} \; \
    && find /var/www/emoncms -type f -name ".gitignore" -depth -exec rm -f {} \; \
    && find /var/www/emoncms -type f -name ".empty" -depth -exec rm -f {} \;

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Emoncms" \
    io.hass.description="Emoncms is a powerful open-source web-app for processing, logging and visualising energy, temperature and other environmental data." \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Malachi Soord" \
    org.opencontainers.image.title="Emoncms" \
    org.opencontainers.image.description="Emoncms is a powerful open-source web-app for processing, logging and visualising energy, temperature and other environmental data." \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Malachi Soord" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/inverse/hassio-addon-emoncms" \
    org.opencontainers.image.documentation="https://github.com/inverse/hassio-addon-emoncms/blob/master/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
