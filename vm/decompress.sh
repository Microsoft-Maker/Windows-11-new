#!/usr/bin/env bash
set -e

if [ ! -f vm/data.img ]; then
  echo "🔧 Decompressing vm/data.7z → vm/data.img..."
  7z x vm/data.7z -ovm
  mv vm/data.qcow2 vm/data.img
  echo "✅ Decompression complete."
else
  echo "ℹ️ vm/data.img already exists; skipping."
fi
