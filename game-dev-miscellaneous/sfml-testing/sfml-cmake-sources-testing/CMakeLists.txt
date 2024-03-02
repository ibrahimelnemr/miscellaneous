# BUILT FROM SOURCE WITHOUT STATIC LINKING
# cmake_minimum_required(VERSION 3.10)
# project(sfml_cmake_sources_testing)

# set(CMAKE_CXX_STANDARD 11)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)
# set(CMAKE_CXX_EXTENSIONS OFF)

# set(SFML_DIR "../SFML-2.5.1-sources/build")
# set(SFML_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../install")

# # set(SFML_STATIC TRUE)

# add_executable(sfml_cmake_sources_testing main.cpp)

# find_package(SFML 2.5.1 COMPONENTS graphics window audio network system REQUIRED)

# target_link_libraries(sfml_cmake_sources_testing PUBLIC sfml-graphics sfml-window sfml-audio sfml-network sfml-system)

# LIBRARY BUILD FROM SOURCE WTIH STATIC LINKING

cmake_minimum_required(VERSION 3.10)
project(sfml_cmake_sources_testing)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(SFML_DIR "../SFML-2.5.1-sources/install/lib/cmake/SFML")
set(SFML_ROOT "../SFML-2.5.1-sources/install/lib/cmake/SFML")

find_package(SFML 2.5.1 COMPONENTS graphics window audio network system REQUIRED)

add_executable(sfml_cmake_sources_testing main.cpp)

target_link_libraries(sfml_cmake_sources_testing PRIVATE sfml-graphics sfml-window sfml-audio sfml-network sfml-system)