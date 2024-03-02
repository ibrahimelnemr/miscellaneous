cmake_minimum_required(VERSION 3.10)
project(sfml_cmake_testing)

set(CMAKE_CXX_STANDARD 11)
set(SFML_DIR "../SFML-2.5.1/include/SFML/SFML.framework/Resources/CMake/")
# set(SFML_DIR "${CMAKE_CURRENT_SOURCE_DIR}/SFML-2.5.1/lib/cmake/SFML")
find_package(SFML 2.5 COMPONENTS graphics REQUIRED)

# add_executable(sfml_cmake_testing ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)
add_executable(sfml_cmake_testing ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)

target_link_libraries(sfml_cmake_testing PRIVATE sfml-graphics)
