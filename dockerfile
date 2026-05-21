ARG VERSION_ARG="latest"
FROM scratch AS build-amd64
COPY --from=qemux/qemu:latest / /

ARG TARGETARCH
ARG VERSION_WSDD="1.24"
ARG VERSION_VIRTIO="1.9.57"

ARG DEBCONF_NOWARNINGS="yes"
ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NONINTERACTIVE_SEEN="true"

RUN set -eu && apt-get update && apt update && apt-get install \
    bc curl 7zip samba xz-utils wimtools dos2unix cabextract genisoimage libxml2-utils \
    libvirt0 libvirt-daemon libvirt-daemon-system --no-install-recommends -y &&\
    wget "https://github.com/gershnik/wsdd-native/releases/download/v${VERSION_WSDD}/wsddn_${VERSION_WSDD}_${TARGETARCH}.deb" -O /tmp/wsddn.deb -q && \
    dpkg -i /tmp/wsddn.deb && \
    apt-get clean && \
    echo "$VERSION_ARG" > /run/version && \
    rm -rf /var/lib/apt/lists* /tmp/* /var/tmp* \
    service libvirt start

COPY --chmod=755 ./src /run/
COPY --chmod=755 ./assets /run/assets

ADD --chmod=664 https://github.com/qemus/virtiso-whql/releases/download/v${VERSION_VIRTIO}-0/virtio-win-${VERSION_VIRTIO}.tar.xz /var/drivers.txz

EXPOSE 8006 3389
VOLUME /storage

ENV RAM_SIZE="4G"
ENV CPU_CORES="3"
ENV DISK_SIZE="30G"
ENV VERSION="win7"

ENTRYPOINT ["/usr/bin/tini", "-s", "/run/entry.sh"]