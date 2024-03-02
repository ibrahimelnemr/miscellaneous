cmake_minimum_required(VERSION 3.10)
project(sfml_cmake_testing)

# Set C++ standard
set(CMAKE_CXX_STANDARD 11)

# Specify the path to SFMLConfig.cmake directory
# set(SFML_DIR "${CMAKE_CURRENT_SOURCE_DIR}/SFML-2.5.1-sources/cmake")
set(SFML_DIR "../SFML-2.5.1-sources/cmake")

# Find SFML package (static linking)
find_package(SFML 2.5 COMPONENTS graphics REQUIRED CONFIG)

# Add executable
add_executable(sfml_cmake_testing main.cpp)

# Link with SFML libraries
target_link_libraries(sfml_cmake_testing PRIVATE sfml-graphics-s sfml-window-s sfml-system-s)