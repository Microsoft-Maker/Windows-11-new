#!/usr/bin/env bash
set -euo pipefail

echo "🧹 Cleaning up temporary files and caches..."
rm -rf /tmp/* /var/tmp/* ~/.cache/*
sync

echo "📊 Current disk usage for root & vm folder:"
df -h / /$(pwd)/vm
