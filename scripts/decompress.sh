#!/usr/bin/env bash
set -euo pipefail

# You can override these:
: "${REPO:=windows-11-enterprise-dind}"
: "${URL_PREFIX:=https://github.com/ItzLevvie/artifacts/releases/download/27924-1/data.7z}"
: "${PARTS:=4}"

TMP_DIR="/tmp/${REPO}"
WORK_DIR="$(pwd)"

# clean and prepare
rm -rf "${TMP_DIR}"
mkdir -p "${TMP_DIR}/windows"
rm -rf "${WORK_DIR}/vm"
mkdir -p "${WORK_DIR}/vm"

# download split archives
for i in $(seq -f "%03g" 1 "${PARTS}"); do
  echo "Downloading part ${i}..."
  wget -q "${URL_PREFIX}.${i}" -O "${TMP_DIR}/windows/data.7z.${i}"
done

# extract into tmp
echo "Extracting data.7z..."
7z x "${TMP_DIR}/windows/data.7z.001" -o"${TMP_DIR}/windows"

# cleanup archives
rm -f "${TMP_DIR}/windows/data.7z."*

# convert VHDX → QCOW2 if needed
if [ -f "${TMP_DIR}/windows/data.vhdx" ]; then
  echo "Converting data.vhdx → data.qcow2..."
  qemu-img convert -p -O qcow2 -o preallocation=off \
    "${TMP_DIR}/windows/data.vhdx" \
    "${TMP_DIR}/windows/data.qcow2"
  rm "${TMP_DIR}/windows/data.vhdx"
fi

# move final image
if [ -f "${TMP_DIR}/windows/data.qcow2" ]; then
  mv "${TMP_DIR}/windows/data.qcow2" "${WORK_DIR}/vm/data.qcow2"
  echo "✅ vm/data.qcow2 is ready."
else
  echo "❌ Extraction failed: no data.qcow2 found."
  exit 1
fi
