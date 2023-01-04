ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:13.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN \
    apk add --no-cache \
        nginx=1.22.1-r0 \
        mariadb-client=10.6.11-r0 \
        php81-ctype=8.1.13-r0 \
        php81-curl=8.1.13-r0 \
        php81-fpm=8.1.13-r0 \
        php81-gettext=8.1.13-r0 \
        php81-mbstring=8.1.13-r0 \
        php81-mysqli=8.1.13-r0 \
        php81-opcache=8.1.13-r0 \
        php81-session=8.1.13-r0 \
        php81-zip=8.1.13-r0 \
        php81=8.1.13-r0 \
    \
    && apk add --no-cache --virtual .build-dependencies \
        git=2.38.2-r0 \
    \
    && git clone --branch 11.2.3 --depth=1 \
        https://github.com/emoncms/emoncms.git /var/www/emoncms ; cd /var/www/emoncms \
    && git clone --branch 2.3.3 --depth=1 \
        https://github.com/emoncms/dashboard.git /var/www/emoncms/Modules/dashboard \
    && git clone --branch 2.2.3 --depth=1 \
        https://github.com/emoncms/graph.git /var/www/emoncms/Modules/graph \
    && git clone --branch 2.6.7 --depth=1 \
        https://github.com/emoncms/app.git /var/www/emoncms/Modules/app \
    && git clone --branch 2.2.0 --depth=1 \
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
