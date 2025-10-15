#!/usr/bin/env bash
set -e

: "${DATA_IMG:=/workspace/vm/data.img}"
: "${EXTRA_GB:=10}"

if [ ! -f "$DATA_IMG" ]; then
  echo "❌ VM image not found at $DATA_IMG"
  exit 1
fi

echo "📏 Expanding disk image by ${EXTRA_GB} GB…"
qemu-img resize "$DATA_IMG" +"${EXTRA_GB}G"

echo "✅ Resize complete. New size:"
qemu-img info "$DATA_IMG" | grep 'virtual size'
