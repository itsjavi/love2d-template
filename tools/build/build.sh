#!/usr/bin/env bash

LOVE_GAME_NAME=${1-${PWD##*/}}

LOVE_BUILD_TARGET=${2-"macos"}
LOVE_BUILD_FILENAME=build/${LOVE_GAME_NAME}.love
LOVE_BUILD_IGNORE=$(cat .loveignore)

mkdir -p build
rm -f ${LOVE_BUILD_FILENAME}
zip -9 -r ${LOVE_BUILD_FILENAME} . -x@.loveignore

./tools/build/targets/${LOVE_BUILD_TARGET}.sh ${LOVE_GAME_NAME}