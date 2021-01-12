ARG BUILD_FROM=hassioaddons/base:8.0.5
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN \
    apk add --no-cache \
        nginx=1.18.0-r1 \
        mariadb-client=10.4.15-r0 \
        php7-ctype=7.3.26-r0 \
        php7-curl=7.3.26-r0 \
        php7-fpm=7.3.26-r0 \
        php7-gettext=7.3.26-r0 \
        php7-json=7.3.26-r0 \
        php7-mysqli=7.3.26-r0 \
        php7-opcache=7.3.26-r00 \
        php7-session=7.3.26-r0 \
        php7-zip=7.3.26-r0 \
        php7=7.3.26-r0 \
    \
    && apk add --no-cache --virtual .build-dependencies \
        git=2.26.2-r0 \
    \
    && git clone --branch 10.2.7 --depth=1 \
        https://github.com/emoncms/emoncms.git /var/www/emoncms \
    \
    && apk del --no-cache --purge .build-dependencies \
    \
    && rm -f -r /var/www/emoncms/.git \
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
