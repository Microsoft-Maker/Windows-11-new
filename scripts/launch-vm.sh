#!/usr/bin/env bash
set -e

# Default to 2 cores, 8 GB RAM; override with env vars
: "${CORES:=2}"
: "${RAM:=8192}"
: "${DATA_IMG:=/workspace/vm/data.img}"

if [ ! -f "$DATA_IMG" ]; then
  echo "❌ VM image not found at $DATA_IMG"
  exit 1
fi

echo "🚀 Launching Windows 11 Enterprise VM"
echo "   • Cores: $CORES"
echo "   • RAM: ${RAM} MB"
echo "   • Image: $DATA_IMG"

qemu-system-x86_64 \
  -enable-kvm \
  -m "$RAM" \
  -smp cores="$CORES" \
  -cpu host \
  -drive file="$DATA_IMG",format=qcow2,if=virtio \
  -netdev user,id=net0 \
  -device virtio-net,netdev=net0 \
  -vga qxl \
  -display gtk \
  -boot c
