#!/usr/bin/env bash
set -euo pipefail

# Override with env vars if you like
: "${CORES:=2}"
: "${RAM:=8192}"        # in MB
IMG_PATH="$(pwd)/vm/data.qcow2"

if [ ! -f "${IMG_PATH}" ]; then
  echo "❌ VM image not found at ${IMG_PATH}"
  exit 1
fi

echo "🚀 Launching Win11 Enterprise"
echo "   • Cores: ${CORES} (max 16)"
echo "   • RAM:   ${RAM} MB"
echo "   • Disk:  ${IMG_PATH}"

qemu-system-x86_64 \
  -enable-kvm \
  -m "${RAM}" \
  -smp cores="${CORES}",maxcpus=16 \
  -cpu host \
  -drive file="${IMG_PATH}",format=qcow2,if=virtio \
  -netdev user,id=net0 \
  -device virtio-net,netdev=net0 \
  -vga qxl \
  -display gtk \
  -boot c
