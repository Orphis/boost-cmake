cmake_minimum_required(VERSION 3.8.0)
project(import_test)

find_package(Boost CONFIG COMPONENTS unit_test_framework)

add_executable(import_test main.cpp)
target_link_libraries(import_test PRIVATE Boost::unit_test_framework Boost::iostreams)
