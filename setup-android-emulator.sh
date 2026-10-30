#!/usr/bin/env bash
# Setup script for Android emulator on macOS (Hackintosh)
# Creates and launches AVD: Android17_Test

set -euo pipefail

ANDROID_HOME="${ANDROID_HOME:-$HOME/Library/Android/sdk}"
AVD_NAME="Android17_Test"
API_LEVEL="35"
ABI="x86_64"
DEVICE="pixel_7"

check_dependencies() {
    if [ ! -d "$ANDROID_HOME" ]; then
        echo "ERROR: Android SDK not found at $ANDROID_HOME"
        echo "Install Android Studio or set ANDROID_HOME to your SDK path."
        exit 1
    fi

    local sdkmanager="$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager"
    if [ ! -f "$sdkmanager" ]; then
        echo "ERROR: sdkmanager not found. Install 'Android SDK Command-line Tools' via Android Studio."
        echo "  Android Studio → SDK Manager → SDK Tools → Android SDK Command-line Tools"
        exit 1
    fi
}

install_components() {
    local sdkmanager="$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager"
    echo "Installing system image for API $API_LEVEL..."
    "$sdkmanager" "system-images;android-${API_LEVEL};google_apis;${ABI}" \
                  "platform-tools" \
                  "emulator"
}

create_avd() {
    local avdmanager="$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager"

    if "$avdmanager" list avd | grep -q "Name: $AVD_NAME"; then
        echo "AVD '$AVD_NAME' already exists, skipping creation."
        return
    fi

    echo "Creating AVD '$AVD_NAME'..."
    echo "no" | "$avdmanager" create avd \
        --name "$AVD_NAME" \
        --package "system-images;android-${API_LEVEL};google_apis;${ABI}" \
        --device "$DEVICE" \
        --force
    echo "AVD '$AVD_NAME' created successfully."
}

launch_emulator() {
    local emulator_bin="$ANDROID_HOME/emulator/emulator"
    echo "Launching emulator with AVD '$AVD_NAME'..."
    "$emulator_bin" -avd "$AVD_NAME" \
        -no-snapshot-load \
        -gpu host \
        &
    echo "Emulator launched (PID $!)."
    echo "Run: $emulator_bin -avd $AVD_NAME"
}

main() {
    echo "=== Android Emulator Setup for Hackintosh ==="
    check_dependencies
    install_components
    create_avd
    launch_emulator
}

main "$@"
