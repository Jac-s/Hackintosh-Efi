#!/usr/bin/env bash
# Quick launcher for Android17_Test AVD

ANDROID_HOME="${ANDROID_HOME:-$HOME/Library/Android/sdk}"
AVD_NAME="${1:-Android17_Test}"

exec "$ANDROID_HOME/emulator/emulator" -avd "$AVD_NAME" -gpu host "$@"
