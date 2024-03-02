# Table of Contents

# SFML Cmake Testing

`mkdir sfml-cmake-testing`

`cd sfml-cmake-testing`

`touch CMakeLists.txt`

`touch main.cpp`

`main.cpp` should have the folowing

```cpp
#include <SFML/Graphics.hpp>

int main() {
    sf::RenderWindow window(sf::VideoMode(800, 600), "SFML Example");

    while (window.isOpen()) {
        sf::Event event;
        while (window.pollEvent(event)) {
            if (event.type == sf::Event::Closed)
                window.close();
        }

        window.clear();
        window.display();
    }

    return 0;
}

// #include <iostream>

// int main() {
//     printf("Working");
//     return 0;
// }
```

CMakeLists.txt should have the following

```m
cmake_minimum_required(VERSION 3.10)
project(sfml_cmake_testing)

set(CMAKE_CXX_STANDARD 11)
set(SFML_DIR "../SFML-2.5.1/include/SFML/SFML.framework/Resources/CMake/")
# set(SFML_DIR "${CMAKE_CURRENT_SOURCE_DIR}/SFML-2.5.1/lib/cmake/SFML")
find_package(SFML 2.5 COMPONENTS graphics REQUIRED)

# add_executable(sfml_cmake_testing ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)
add_executable(sfml_cmake_testing ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)

target_link_libraries(sfml_cmake_testing PRIVATE sfml-graphics)
```

Given that SFML 2.5.1 is present in a folder named "SFML-2.5.1" in the parent directory

If not, download from [https://www.sfml-dev.org/download.php] and rename folder to `SFML-2.5.1`. Add other SFML versions to parent directory if needed.

For testing I have used
`SFML-2.3.2`

`SFML-2.4.2`

`SFML-2.5.0`

`SFML-2.5.1`

`SFML-2.3.2`

`SFML-2.6.1`



`mkdir build`

`cd build`

`cmake ..`

`cmake --build .`

You should now find a file `sfml_cmake_testing` in the main directory, run it with `./sfml_cmake_testing`

# SFML Cmake Testing (build from source)

`mkdir sfml-cmake-sources-testing`

`cd sfml-cmake-sources-testing`

`touch CMakeLists.txt`

`touch main.cpp`

`main.cpp` should have the folowing

```cpp
// #include <SFML/Graphics.hpp>

// int main() {
//     sf::RenderWindow window(sf::VideoMode(800, 600), "SFML Example");

//     while (window.isOpen()) {
//         sf::Event event;
//         while (window.pollEvent(event)) {
//             if (event.type == sf::Event::Closed)
//                 window.close();
//         }

//         window.clear();
//         window.display();
//     }

//     return 0;
// }


// #include <iostream>

// int main() {
//     printf("Working");
//     return 0;
// }
```

Now, we will build SFML from source and link it statically
`cd ../SFML-2.5.1-sources`

`mkdir build`

`cd build`

`cmake .. -DSFML_BUILD_STATIC=TRUE`

`make`

`make installs`

CMakeLists.txt should have the following

```m
cmake_minimum_required(VERSION 3.10)
project(sfml_cmake_testing)

# Set C++ standard
set(CMAKE_CXX_STANDARD 11)

# Specify the path to SFMLConfig.cmake directory
set(SFML_DIR "${CMAKE_CURRENT_SOURCE_DIR}/SFML-2.5.1-sources/cmake")

# Find SFML package (static linking)
find_package(SFML 2.5 COMPONENTS graphics REQUIRED CONFIG)

# Add executable
add_executable(sfml_cmake_testing main.cpp)

# Link with SFML libraries
target_link_libraries(sfml_cmake_testing PRIVATE sfml-graphics-s sfml-window-s sfml-system-s)

```

`mkdir build`

`cd build`

`cmake ..`

`cmake --build .`

You should now find a file `sfml_cmake_sources_testing` in the main directory, run it with `./sfml_cmake_sources_testing`