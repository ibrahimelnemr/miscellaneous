cmake_minimum_required(VERSION 3.10)
project(raylib_example)

set(CMAKE_C_STANDARD 11)

find_package(raylib 4.5 REQUIRED PATHS /usr/local/Cellar/raylib/5.0)

add_executable(raylib_example main.c)

target_link_libraries(raylib_example PRIVATE raylib)
