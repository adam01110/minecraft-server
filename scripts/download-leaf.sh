#!/usr/bin/env bash

# configuration
REPO="Winds-Studio/Leaf"
VERSION="${VERSION:-1.21.7}"

# paths and files
JAR_DIR="$(dirname "$(cd "$(dirname "$0")" && pwd)")/jar"
VERSION_FILE="${JAR_DIR}/leaf-version.txt"
JAR_FILE="${JAR_DIR}/leaf.jar"
TMP_JSON="${JAR_DIR}/tag-release.json"

# fetch tag release json
curl -s "https://api.github.com/repos/${REPO}/releases/tags/ver-${VERSION}" -o "${TMP_JSON}"

# check if tag exists
if ! jq -e . >/dev/null 2>&1 <"${TMP_JSON}"; then
  echo "󰅙 Failed to fetch release info for tag ver-${VERSION}"
  rm -f "${TMP_JSON}"
  exit 1
fi

# parse asset name, url & expected sha256
ASSET_NAME=$(jq -r '.assets[] | select(.name|test("^leaf-.*\\.jar$")) | .name' "${TMP_JSON}")
JAR_URL=$(jq -r --arg name "${ASSET_NAME}" '.assets[] | select(.name==$name) | .browser_download_url' "${TMP_JSON}")
SHA256_EXPECTED=$(jq -r '.body' "${TMP_JSON}" | grep -A1 "SHA256" | grep -oE '[a-f0-9]{64}')
if [[ -z "${ASSET_NAME}" || -z "${JAR_URL}" || -z "${SHA256_EXPECTED}" ]]; then
  echo "󰅙 Failed to parse release info for tag ver-${VERSION}"
  rm -f "${TMP_JSON}"
  exit 1
fi

echo "󰏔 Tag: ver-${VERSION}"
echo "󰏔 Asset: ${ASSET_NAME}"
echo "󰕥 Expected SHA256: ${SHA256_EXPECTED}"

# compare with last stored version (no .jar)
LAST_ASSET=""
if [[ -f "${VERSION_FILE}" ]]; then
  LAST_ASSET=$(cat "${VERSION_FILE}")
fi

ASSET_NAME_NO_EXT="${ASSET_NAME%.jar}"
if [[ "${ASSET_NAME_NO_EXT}" == "${LAST_ASSET}" ]]; then
  echo "󰄬 Already up to date (${LAST_ASSET})"
  rm -f "${TMP_JSON}"
  exit 0
fi

# download new .jar
echo "󰇚 Downloading ${ASSET_NAME}..."
curl -L -o "${JAR_FILE}" "${JAR_URL}"

# verify checksum
echo "󰱼 Verifying SHA256..."
SHA256_ACTUAL=$(sha256sum "${JAR_FILE}" | awk '{print $1}')
if [[ "${SHA256_ACTUAL}" != "${SHA256_EXPECTED}" ]]; then
  echo "󰅙 SHA256 mismatch: expected ${SHA256_EXPECTED} but got ${SHA256_ACTUAL}"
  rm -f "${JAR_FILE}" "${TMP_JSON}"
  exit 1
fi

# record new version (strip .jar) and cleanup
echo "${ASSET_NAME_NO_EXT}" >"${VERSION_FILE}"
echo "󰄬 Downloaded & verified ${ASSET_NAME}"
rm -f "${TMP_JSON}"
