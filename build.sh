#/usr/bin/env bash

# Latest LTS Version (r23c)
NDK_VER=android-ndk-r23c

download_extract() {
    aria2c -x 16 $1 -o $2
    tar -xf $2
}

download_extract_zip() {
    aria2c --file-allocation=none --timeout=120 --retry-wait=5 --max-tries=20 -Z -c $1 -o $2
    unzip $2 2>&1 > /dev/null
}

brew_install() {
    brew install $1 || brew outdated $1 || brew upgrade $1
}

build_before_install() {
    git submodule update --init --recursive

    if [[ "$AGENT_OS" == "Darwin" ]]; then
        brew update
    elif [[ "$AGENT_OS" == "Linux" ]]; then
        sudo apt-get update
    fi
}

build_install() {
    # Ubuntu Linux + GCC
    if [[ "$AGENT_OS" == "Linux" ]]; then
        sudo apt-get install \
            build-essential \
            g++ \
            clang-12 \
            aria2 \
            ninja-build \
            ccache

        pip install cmake ninja
    elif [[ "$AGENT_OS" == "Darwin" ]]; then
        brew_install ccache
        brew_install cmake
        brew_install ninja
    elif [[ "$AGENT_OS" =~ "Windows" ]]; then
        choco install vswhere
        choco install ninja
    fi

    # Android NDK
    if [[ "$BUILD_TARGET" == "Android" ]]; then
        download_extract_zip http://dl.google.com/android/repository/${NDK_VER}-linux.zip ${NDK_VER}-linux.zip
        export ANDROID_NDK=$(pwd)/${NDK_VER}
    fi
}

build_script() {
    mkdir build
    pushd build

    if [[ "$BUILD_TARGET" == "Linux" ]]; then
        if [[ "$BUILD_COMPILER" == "GCC" ]]; then
            CC=gcc
            CXX=g++
        else
            CC=clang-12
            CXX=clang++-12
        fi
        cmake .. -GNinja \
                 -DCMAKE_C_COMPILER=$CC \
                 -DCMAKE_CXX_COMPILER=$CXX
    elif [[ "$BUILD_TARGET" == "Android" ]]; then
        cmake .. -GNinja \
                 -DCMAKE_SYSTEM_NAME=Android \
                 -DCMAKE_ANDROID_NDK_TOOLCHAIN_VERSION=clang \
                 -DCMAKE_ANDROID_ARCH_ABI=${BUILD_ARCH}
    elif [[ "$BUILD_TARGET" == "macOS" ]]; then
        cmake .. -GNinja
    elif [[ "$BUILD_TARGET" == "iOS" ]]; then
        cmake .. -GNinja \
                 -DCMAKE_TOOLCHAIN_FILE=../cmake/Toolchains/ios.cmake
    elif [[ "$BUILD_TARGET" == "Windows" ]]; then
        vcpath=$(vswhere.exe -latest -property installationPath)
        vcscript="\"$vcpath\\VC\\Auxiliary\\Build\\vcvarsall.bat\" $BUILD_TOOLCHAIN"
        cmd.exe /c "$vcscript & cmake .. -GNinja -DCMAKE_C_COMPILER=cl.exe -DCMAKE_CXX_COMPILER=cl.exe & ninja -v"
        exit 0
    fi

    ninja -v
}

build_after_success() {
    if command -v ccache ; then
        ccache -s
    fi
}

set -e
set -x

build_before_install
build_install
build_script
build_after_success
