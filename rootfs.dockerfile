# syntax=docker.io/docker/dockerfile:1.4
# ARG OPERATOR_ADDRESS=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
ARG RIV_VERSION=0.3-rc16
ARG CARTESAPP_VERSION=devel

FROM --platform=linux/riscv64 ghcr.io/prototyp3-dev/cartesapp-rootfs:${CARTESAPP_VERSION}

# LABEL io.cartesi.rollups.ram_size=128Mi
# LABEL io.cartesi.rollups.data_size=32Mb
# LABEL io.cartesi.rollups.flashdrive_size=1024Mb

# RUN <<EOF
# apt-get update && \
# apt-get install -y --no-install-recommends busybox-static=1:1.30.1-7ubuntu3 \
#     build-essential=12.9ubuntu3 sqlite3=3.37.2-2ubuntu0.3 git=1:2.34.1-1ubuntu1.11 \
#     squashfs-tools=1:4.5-3build1 xdelta3=3.0.11-dfsg-1.2 patch=2.7.6-7build2 && \
# rm -rf /var/lib/apt/lists/* /var/log/* /var/cache/* && \
# useradd --create-home --user-group dapp
# EOF

# Install tools
RUN <<EOF
set -e
apk update
apk add --no-interactive \
    squashfs-tools=4.6.1-r1 xdelta3=3.1.0-r2 patch=2.7.6-r10
EOF

# Install dependencies
COPY extra-requirements.txt .
RUN <<EOF
set -e
pip install -r extra-requirements.txt --no-cache
find /usr/local/lib -type d -name __pycache__ -exec rm -r {} +
EOF

# Install RIVOS
ARG RIV_VERSION
ADD --chmod=644 https://github.com/rives-io/riv/releases/download/v${RIV_VERSION}/rivos.ext2 /rivos.ext2
ADD --chmod=644 https://raw.githubusercontent.com/rives-io/riv/v${RIV_VERSION}/rivos/skel/etc/sysctl.conf /etc/sysctl.conf
ADD --chmod=755 https://raw.githubusercontent.com/rives-io/riv/v${RIV_VERSION}/rivos/skel/etc/cartesi-init.d/riv-init /etc/cartesi-init.d/riv-init

COPY --chmod=755 <<EOF /etc/cartesi-init.d/envs-init
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
EOF

RUN mkdir -p /rivos /cartridges

COPY --chmod=755 <<EOF /usr/sbin/riv-mount
if [ -f /rivos-\$1.ext2 ]; then
    rivos="/rivos-\$1.ext2";
else
    rivos="/rivos.ext2";
fi
mount -o ro,noatime,nosuid -t ext2 \$rivos /rivos
mount --bind /cartridges /rivos/cartridges
EOF

COPY --chmod=755 <<EOF /usr/sbin/riv-umount
umount /rivos/cartridges
umount /rivos
EOF

# Clean
RUN <<EOF
set -e
find /usr/local/lib -type d -name __pycache__ -exec rm -r {} +
rm -rf /var/cache/apk /var/log/* /var/cache/* /tmp/*
EOF

# install dapp
# WORKDIR /mnt/app

# ARG OPERATOR_ADDRESS
# ENV OPERATOR_ADDRESS=${OPERATOR_ADDRESS}
# ENV ROLLUP_HTTP_SERVER_URL="http://127.0.0.1:5004"

# FROM base as dapp

COPY --chmod=755 <<EOF /usr/local/bin/entrypoint.sh
#!/bin/bash
while : ; do
	echo "Initializing Dapp"
	$@
done
EOF

# ENTRYPOINT ["bash"]
# CMD ["entrypoint.sh"]
