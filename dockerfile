from scratch
copy --from=qemux/qemu-docker:latest / /

ARG VERSION_ARG="0.1"
ARG DEBCONF_NOWARNINGS="yes"
ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOINTERACTIVE_SEEN="true"

RUN set -eu && apt-get update && apt update && apt-get install --no-install-recommends -y \
    bc curl 7zip wsdd samba xz-utils wimtools dos2unix cabextract genisoimage libxml2-utils && \
    apt install libvirt0 libvirt-daemon libvirt-daemon-system --no-recommends-install \
    apt-get clean && \
    echo "$VERSION_ARG" > /run/version && \
    rm -rf /var/lib/apt/lists* /tmp/* /var/tmp* \
    service libvirt start

    COPY --chmod=755 ./src /run/
    COPY --chmod=755 ./assets /run/assets
    
    ADD --chmod=755 https://raw.githubusercontent.com/christgau/wsdd/v0.8/src/wsdd.py /usr/sbin/wsdd
    ADD --chmod=664 https://github.com/qemus/virtiso-whql/releases/download/v1.9.43-0/virtio-win-1.9.43.tar.xz /drivers.txz
    
    EXPOSE 8006 3389
    VOLUME /storage
    
    ENV RAM_SIZE="4G"
    ENV CPU_CORES="2"
    ENV DISK_SIZE="64G"
    ENV VERSION="win11"
    
    ENTRYPOINT ["/usr/bin/tini", "-s", "/run/entry.sh"]