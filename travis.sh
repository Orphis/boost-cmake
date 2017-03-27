#/usr/bin/env bash

NDK_VER=android-ndk-r14b

if [ -f "travis_env.sh" ]; then
  . travis_env.sh
fi

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

travis_before_install() {
    git submodule update --init --recursive

    if [ "$TRAVIS_OS_NAME" = "osx" ]; then
        brew update
    fi
}

travis_install() {
    # Ubuntu Linux + GCC 4.8
    if [ "$TRAVIS_OS_NAME" = "linux" ]; then
        download_extract "https://cmake.org/files/v3.7/cmake-3.7.2-Linux-x86_64.tar.gz" cmake-3.7.2-Linux-x86_64.tar.gz
        echo "export PATH=$(pwd)/cmake-3.7.2-Linux-x86_64/bin:\$PATH" >> travis_env.sh
    elif [ "$TRAVIS_OS_NAME" = "osx" ]; then
        brew_install ccache
        brew_install cmake
        brew_install ninja
    fi

    # Android NDK
    if [ "$BUILD_TARGET" = "Android" ]; then
        download_extract_zip http://dl.google.com/android/repository/${NDK_VER}-linux-x86_64.zip ${NDK_VER}-linux-x86_64.zip
        echo "export ANDROID_NDK=$(pwd)/${NDK_VER}" >> travis_env.sh
    fi
}

travis_script() {
    mkdir build
    pushd build

    if [ "$BUILD_TARGET" = "Linux" ]; then
        cmake .. -GNinja \
                 -DCMAKE_C_COMPILER=gcc-5 \
                 -DCMAKE_CXX_COMPILER=g++-5
    elif [ "$BUILD_TARGET" = "Android" ]; then
        cmake .. -GNinja \
                 -DCMAKE_SYSTEM_NAME=Android \
                 -DCMAKE_ANDROID_NDK_TOOLCHAIN_VERSION=clang \
                 -DCMAKE_ANDROID_ARCH_ABI=${BUILD_ARCH}
    elif [ "$BUILD_TARGET" = "macOS" ]; then
        cmake .. -GNinja
    elif [ "$BUILD_TARGET" = "iOS" ]; then
        cmake .. -GNinja \
                 -DCMAKE_TOOLCHAIN_FILE=../cmake/Toolchains/ios.cmake
    fi

    ninja -v
}

travis_after_success() {
    ccache -s
}

set -e
set -x

$1;
