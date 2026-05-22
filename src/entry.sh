#!/usr/bin/env bash
set -Eeuo pipefail

: "${BOOT_MODE:="windows"}"
: "${PLATFORM:="x64"}"

# Default port configuration (lost from qemux/qemu ENV due to FROM scratch)
: "${VNC_PORT:="5900"}"   # VNC server port
: "${WSS_PORT:="8006"}"   # WebSocket port (web browser access)
: "${MON_PORT:="7100"}"   # QEMU monitor port
: "${WEB_PORT:="8006"}"   # Web interface port
: "${WSD_PORT:="3702"}"   # WS-Discovery daemon port

APP="Windows"
SUPPORT="https://github.com/dockur/windows"

cd /run

. utils.sh      # Load functions
. reset.sh      # Initialize system
. define.sh     # Define versions
. mido.sh       # Download code
. install.sh    # Run installation
. disk.sh       # Initialize disks
. display.sh    # Initialize graphics
. network.sh    # Initialize network
. samba.sh      # Configure samba
. boot.sh       # Configure boot
. proc.sh       # Initialize processor
. power.sh      # Configure shutdown
. config.sh     # Configure arguments
. custom_network.sh # Configure second network interface


trap - ERR

version=$(qemu-system-x86_64 --version | head -n 1 | cut -d '(' -f 1 | awk '{ print $NF }')
info "Booting ${APP}${BOOT_DESC} using QEMU v$version..."

{ qemu-system-x86_64 ${ARGS:+ $ARGS} >"$QEMU_OUT" 2>"$QEMU_LOG"; rc=$?; } || :
(( rc != 0 )) && error "$(<"$QEMU_LOG")" && exit 15

terminal
( sleep 30; boot ) &
tail -fn +0 "$QEMU_LOG" 2>/dev/null &
cat "$QEMU_TERM" 2> /dev/null | tee "$QEMU_PTY" &
wait $! || :

sleep 1 & wait $!
[ ! -f "$QEMU_END" ] && finish 0
