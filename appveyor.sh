if [ "$BUILD_TOOLSET" == "v140" ]; then
  vcscript="\"$VS140COMNTOOLS\\..\\..\\VC\\vcvarsall.bat\" $BUILD_TOOLCHAIN"
elif [ "$BUILD_TOOLSET" == "v141" ]; then
  vcpath=$(vswhere.exe -latest -property installationPath)
  vcscript="\"$vcpath\\VC\\Auxiliary\\Build\\vcvarsall.bat\" $BUILD_TOOLCHAIN"
fi

mkdir build
cd build

cmd.exe /c "$vcscript & cmake .. -GNinja & ninja -v"
