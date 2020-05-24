ARG BUILD_FROM=hassioaddons/base:7.2.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Copy Node-RED package.json
COPY package.json /opt/

# Set workdir
WORKDIR /opt

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN apk add --no-cache --virtual .build-dependencies \
        py2-pip \
        python2-dev \
        make \
        gcc \
        g++ \
        linux-headers \
        udev
RUN apk add --update --no-cache "nodejs<13" "npm<13"
RUN npm config set unsafe-perm true
RUN npm install \
        --no-audit \
        --no-optional \
        --no-update-notifier \
        --only=production \
        --unsafe-perm
RUN npm cache clear --force
RUN apk del --no-cache --purge .build-dependencies
RUN rm -fr /tmp/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Node-RED Minimal" \
    io.hass.description="Flow-based programming for the Internet of Things" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    org.opencontainers.image.title="Node-RED Minimal" \
    org.opencontainers.image.description="Flow-based programming for the Internet of Things" \
    org.opencontainers.image.authors="Originally Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/IceEyz/addon-node-red-minimal" \
    org.opencontainers.image.documentation="https://github.com/IceEyz/addon-node-red-minimal/blob/master/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
