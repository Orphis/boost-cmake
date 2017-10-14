# Boost CMake [![Build Status](https://travis-ci.org/Orphis/boost-cmake.svg?branch=master)](https://travis-ci.org/Orphis/boost-cmake)

## Synopsis

Easy Boost integration in CMake projects!

## Code Example

Install the submodule in your project structure:
```
git submodule add https://github.com/Orphis/boost-cmake.git
```
Use it! In you CMakeLists.txt file:

```
add_subdirectory(boost-cmake)
...
target_link_libraries(lib_using_filesystem PUBLIC Boost::filesystem)
target_link_libraries(lib_using_header_only PUBLIC Boost::boost)
```

## Configuration

Boost will automatically be downloaded from GitHub as a minified archive created with the `repack.sh` script.

If that is not acceptable to you, you can use an alternate Boost version, apply custom patches or just mirror the current archive in your internal network like so:
```
set(BOOST_URL http://internal.mirror/boost.7z)
set(BOOST_URL_SHA256 foobar)
add_subdirectory(boost-cmake)
```

If you have Boost sources already available and want to point to them, you can use the following:
```
set(BOOST_SOURCE /path/to/boost)
add_subdirectory(boost-cmake)
```

You can specify a subset of compiled libraries, which will be included to project. This can be useful for a build with MSVC compiler.
'''
set(BOOST_LIBS_OPTIONAL filesystem program_options system CACHE STRING "" FORCE)
add_subdirectory(boost-cmake)
'''

## Motivation

Most people struggle building Boost for various platforms or using package managers to get the right version, so I figured I would open-source the solution similar to the one I developed while I worked at Spotify.

Using this, as long as your main project is configured properly, Boost will be built with the same compiler, same architectures (in case of universal macOS or iOS build), same compilation flags (think of Clang sanitizers for example) without any hassle.

The Boost sources will be automatically downloaded from CMake if they cannot be found. You can also fork the project and add the boost source package if you wish to do so, or use an alternative URL pointing for example to an HTTP cache internal to your network.

## Contributors

Not all libraries are currently built. Patches accepted to build the remaining ones!

## License

BSD 3-clause license. See LICENSE.md file.
