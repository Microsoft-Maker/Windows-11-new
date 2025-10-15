#!/usr/bin/env bash
set -e

echo "🧹 Cleaning up temporary files and logs…"
rm -rf /tmp/* /var/tmp/* ~/.cache/* /var/log/*.log
sync

echo "📊 Current disk usage:"
df -h | grep -E '^/dev/(sda|vda)' || df -h
