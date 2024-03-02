cmake_minimum_required(VERSION 3.10)
project(raylib_example)

set(CMAKE_CXX_STANDARD 11)

find_package(raylib 3.7.0 REQUIRED)

add_executable(raylib_example main.cpp)

target_link_libraries(raylib_example PRIVATE raylib)
