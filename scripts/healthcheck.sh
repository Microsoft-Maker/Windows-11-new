#!/usr/bin/env bash
set -e

THRESHOLD=${THRESHOLD:=90}
USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

if [ "$USAGE" -ge "$THRESHOLD" ]; then
  echo "🚨 Disk usage at ${USAGE}% (>= ${THRESHOLD}%)"
  exit 1
else
  echo "✅ Disk usage OK: ${USAGE}% (< ${THRESHOLD}%)"
  exit 0
fi
