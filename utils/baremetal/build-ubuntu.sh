#!/usr/bin/env bash
set -e

LOCAL_DIR="$(cd "$(dirname "$0")" && pwd)"
SWIFT_PATH="$( cd "$(dirname "$0")/../../.." && pwd )"

# Install ARM toolchain and utilities
# sudo apt update
sudo apt install -y gdb-multiarch gcc-arm-none-eabi binutils-arm-none-eabi openocd

# Build swift
PYTHON_EXEC="${PYTHON_EXEC:-$(command -v python)}"
EXTRA_CMAKE_OPTIONS+=" -DPYTHON_EXECUTABLE:FILEPATH=$PYTHON_EXEC"
EXTRA_CMAKE_OPTIONS+=" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
if [[ "$OSTYPE" == "darwin"* ]]; then
  EXTRA_CMAKE_OPTIONS+=" -DSWIFT_ENABLE_GOLD_LINKER=NO"
fi

"$SWIFT_PATH"/swift/utils/build-script \
		--extra-cmake-options="$EXTRA_CMAKE_OPTIONS" \
		--stdlib-deployment-targets  "baremetal-thumbv7m" \
		--export-compile-commands \
        --baremetal \
		--build-swift-dynamic-sdk-overlay 0 \
		--build-swift-static-stdlib 1 \
		--build-swift-dynamic-stdlib 0 \
		--build-swift-remote-mirror 0 \
        --skip-build-benchmarks 1 \
        "$@"
        #--build-sil-debugging-stdlib 1 \
