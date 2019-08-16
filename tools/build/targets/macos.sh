#!/usr/bin/env bash

if [[ "$OSTYPE" != "darwin"* ]]; then
    # not macOS
    exit
fi

command_exists() {
    command -v "$@" >/dev/null 2>&1
}

if ! command_exists love; then
    echo "love executable not found"
    exit 1
fi

LOVE_VERSION=$(love --version)
LOVE_GAME_NAME=${1-${PWD##*/}}
LOVE_SRC_BUILD_FILENAME=build/${LOVE_GAME_NAME}.love
LOVE_TARGET_BUILD_FILENAME=build/${LOVE_GAME_NAME}.app

LOVE_PATH=$(realpath $(which love))
LOVE_APP_PATH=$(dirname $(dirname $(dirname ${LOVE_PATH})))

if [[ ! -d "${LOVE_APP_PATH}" ]] || [[ ! -d "${LOVE_APP_PATH}/Contents/Resources/" ]]; then
    echo "love.app not found. LOVE_PATH=${LOVE_PATH} ; LOVE_APP_PATH=${LOVE_APP_PATH}"
    exit 1
fi

mkdir -p build
rm -rf ${LOVE_TARGET_BUILD_FILENAME}
cp -R ${LOVE_APP_PATH} ${LOVE_TARGET_BUILD_FILENAME}
cp -Rp ${LOVE_SRC_BUILD_FILENAME} ${LOVE_TARGET_BUILD_FILENAME}/Contents/Resources/

if [[ ! -f "${LOVE_TARGET_BUILD_FILENAME}/Contents/Resources/${LOVE_GAME_NAME}.love" ]]; then
    echo "love game not copied properly."
    exit 1
fi

LOVE_APP_PLIST="${LOVE_TARGET_BUILD_FILENAME}/Contents/Info.plist"

plutil -remove UTExportedTypeDeclarations ${LOVE_APP_PLIST}
plutil -remove CFBundleDocumentTypes ${LOVE_APP_PLIST}
plutil -replace CFBundleIdentifier -string "com.${LOVE_GAME_NAME}" ${LOVE_APP_PLIST}
plutil -replace CFBundleName -string "${LOVE_GAME_NAME}" ${LOVE_APP_PLIST}
plutil -replace NSHumanReadableCopyright -string "© 2019, The ${LOVE_GAME_NAME} Team" ${LOVE_APP_PLIST}
plutil -replace CFBundleIconFile -string "OS X AppIcon" ${LOVE_APP_PLIST}
plutil -replace CFBundleIconName -string "OS X AppIcon" ${LOVE_APP_PLIST}
plutil -replace CFBundleShortVersionString -string "1.0.0 + LÖVE 11.2" ${LOVE_APP_PLIST}

open ${LOVE_TARGET_BUILD_FILENAME}