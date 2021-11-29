#!/usr/bin/env bash

set -e

BOOST_VERSION=1.67.0

function finish {
  rm -rf "${tmp_dir}"
}
trap finish EXIT

undotted_BOOST_VERSION="${BOOST_VERSION//\./_}"
out_dir="$(pwd)"
patch_dir="$(pwd)/patch/${BOOST_VERSION}"
tmp_dir="$(mktemp -d)"
extract_dir="${tmp_dir}/extract"
orig_boost_file="${tmp_dir}/boost_${BOOST_VERSION}.tar.bz2"

echo "Downloading Boost ${BOOST_VERSION}..."
curl -L "https://boostorg.jfrog.io/artifactory/main/release/${BOOST_VERSION}/source/boost_${undotted_BOOST_VERSION}.tar.bz2" -o "$orig_boost_file"

mkdir -p "$extract_dir"
cd "$extract_dir"
echo "Extracting archive..."
tar -xjf "$orig_boost_file"

cd boost_*

if [ -d "${patch_dir}" ]; then
  mkdir patch
  for f in "${patch_dir}"/*.patch; do
    echo "Applying patch ${f}..."
    git apply --verbose "$f"
    cp "$f" patch/
  done
fi

echo "Removing extra files..."
find . \
  \( \
    -name "doc" -prune -or \
    -name "*.htm*" -or \
    -name "*.png" -or \
    -name "*.bmp" -or \
    -name "*.jpg" \
  \) \
  -exec rm -rf {} +

cd ..
echo "Recompressing archive..."
tar -I "xz -z9evT0" -cf "${out_dir}/boost_${undotted_BOOST_VERSION}.tar.xz" boost_*
