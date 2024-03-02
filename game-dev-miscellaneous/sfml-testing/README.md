# Table of Contents

[SFML CMake testing](#sfml-cmake-testing)

[SFML Cmake Testing (build from source dynamic linking default install directory)](#sfml-cmake-testing-build-from-source-dynamic-linking-default-install-directory) Works ✅

[SFML CMake Testing build from source static custom install directory](#sfml-cmake-testing-build-from-source-static-custom-install-directory)

[SFML CMake Testing build from source static default install directory](#sfml-cmake-testing-build-from-source-static-default-install-directory)

[SFML Cmake Testing Build from source / Static linking / Custom install directory](#sfml-cmake-testing-build-from-source--static-linking--custom-install-directory) Works ✅

[CSFML CMake Sources Testing](#csfml-cmake-sources-testing)

[CSFML CMake Sources Static Testing](#csfml-cmake-sources-static-testing)

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

# SFML Cmake Testing (build from source dynamic linking default install directory)

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


#include <iostream>

int main() {
    printf("Working");
    return 0;
}
```

Now, we will build SFML from source and link it statically
`cd ../SFML-2.5.1-sources`

`mkdir build`

`cd build`


try this option to build it in the install directory. 
`cmake .. -DCMAKE_INSTALL_PREFIX=../install`

This is a custom directory, if this causes issues, then try again with 
`cmake ..`

`make`

`make install`
If you get an error like the following
```
-- Installing: /Library/Frameworks/freetype.framework
CMake Error at cmake_install.cmake:77 (file):
  file INSTALL cannot make directory
  "/Library/Frameworks/freetype.framework": Permission denied.
```
Then run `sudo make install`

Return to the `sfml_cmake_testing` directory

CMakeLists.txt in `sfml_cmake_testing` should have the following

```m
cmake_minimum_required(VERSION 3.10)
project(sfml_cmake_testing)

set(CMAKE_CXX_STANDARD 11)

set(SFML_DIR "../SFML-2.5.1-sources/build")

set(SFML_STATIC_LIBRARIES TRUE)

find_package(SFML 2.5.1 COMPONENTS graphics REQUIRED)

add_executable(sfml_cmake_testing main.cpp)

target_compile_definitions(sfml_cmake_testing PUBLIC SFML_STATIC)

target_link_libraries(sfml_cmake_testing PUBLIC sfml-graphics)
```

`mkdir build`

`cd build`

`cmake ..`

`cmake --build .`

You should now find a file `sfml_cmake_sources_testing` in the main directory, run it with `./sfml_cmake_sources_testing`

If you get errors similar to the following on macOS:

`“vorbisenc.framework” cannot be opened because the developer cannot be verified.`

Then for each error, open "Privacy and Security" in settings, click "Allow Anyway" to the popup, and then run the executable again.

# SFML Cmake Testing (build from source STATIC CUSTOM INSTALL DIRECTORY)

Do the same as build from source, except:

Instead of running
`cmake .. -DCMAKE_INSTALL_PREFIX=../install`

Run
`cmake .. -DCMAKE_INSTALL_PREFIX=../install -DBUILD_SHARED_LIBS=FALSE`

To link the libraries statically

Then run 

`make`
and `sudo make install`

Your CMakeLists.txt in the `sfml-cmake-sources-testing` directory should look like this:

```m
cmake_minimum_required(VERSION 3.10)
project(sfml_cmake_sources_testing)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(SFML_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../install")

find_package(SFML 2.5.1 COMPONENTS graphics window audio network system REQUIRED)

add_executable(sfml_cmake_sources_testing main.cpp)

target_link_libraries(sfml_cmake_sources_testing PRIVATE sfml-graphics sfml-window sfml-audio sfml-network sfml-system)
```

To test the static library from the command line, you can also run 
`cd sfml-cmake-sources-testing`

Then run
```bash
g++ \
-std=c++11 \
-Wall \
-Wextra \
-Werror \
-o main main.cpp \
-I../SFML-2.5.1-sources/install/include \
-L../SFML-2.5.1-sources/install/lib \
-lsfml-system-s \
-lsfml-network-s \
-lsfml-graphics-s \
-lsfml-window-s \
-lsfml-audio-s \
-Wl,-rpath ../SFML-2.5.1-sources/install/lib \
;
```

`./main`


# SFML Cmake Testing (build from source STATIC DEFAULT INSTALL DIRECTORY)

Do the same as build from source with custom install directory, except

Instead of running (to build from source)
`cmake ..  -DBUILD_SHARED_LIBS=FALSE`

Run
`cmake .. -DBUILD_SHARED_LIBS=FALSE`

To link the libraries statically and not use any custom install directory

Since using a custom install directory may lead to problems with SFML finding the install directory

Your CMakeLists.txt in the `sfml-cmake-sources-testing` directory should look like this:

```m
set(SFML_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../install")
```

# SFML Cmake Testing Build from source / Static linking / Custom install directory

`mkdir sfml-cmake-sources-static-testing`

`cd sfml-cmake-sources-static-testing`

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

Now, we will build SFML from source and link it statically. If SFML has already been built from source and linked statically, skip this step.

`cd ../SFML-2.5.1-sources`

`mkdir build`

`cd build`


try this option to build it in the install directory. 

`cmake .. -DCMAKE_INSTALL_PREFIX=../install`

This is a custom directory, if this causes issues, then try again with 

`cmake ..`

`make`

`make install`

If you get an error like the following

```
-- Installing: /Library/Frameworks/freetype.framework
CMake Error at cmake_install.cmake:77 (file):
  file INSTALL cannot make directory
  "/Library/Frameworks/freetype.framework": Permission denied.
```

Then run `sudo make install`

Return to the `sfml_cmake_testing` directory

CMakeLists.txt in `sfml-cmake-sources-static-testing` should have the following

```m
cmake_minimum_required(VERSION 3.10)
project(sfml_cmake_sources_static_testing)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(SFML_DIR "../SFML-2.5.1-sources/build")

find_package(SFML 2.5.1 COMPONENTS graphics window audio network system REQUIRED)

add_executable(sfml_cmake_sources_static_testing main.cpp)

target_link_libraries(sfml_cmake_sources_static_testing PRIVATE sfml-graphics sfml-window sfml-audio sfml-network sfml-system)
```

`mkdir build`

`cd build`

`cmake ..`

`cmake --build .`

You should now find a file `sfml_cmake_sources_static_testing` in the main directory, run it with `./sfml_cmake_sources_static_testing`


# CSFML CMake Sources Testing

Download CSFML 2.5.1 macOS from [https://www.sfml-dev.org/download/csfml/] to the directory on the same level as `csfml-cmake-sources-testing`

This CSFML folder should be named `CSFML-2.5.1-macOS-clang`

`mkdir csfml-cmake-sources-testing`

`cd csfml-cmake-sources-testing`

`touch CMakeLists.txt`

`touch main.c`

`main.c` should have the folowing

```cpp
#include <SFML/Graphics.h>

int main() {

    sfVideoMode mode = {800, 600, 32};
    sfRenderWindow* window = sfRenderWindow_create(mode, "SFML Example", sfResize | sfClose, NULL);
    if (!window) {
        return -1;
    }


    while (sfRenderWindow_isOpen(window)) {

        sfEvent event;
        while (sfRenderWindow_pollEvent(window, &event)) {
            if (event.type == sfEvtClosed) {
                sfRenderWindow_close(window);
            }
        }

        sfRenderWindow_clear(window, sfBlack);

        sfRenderWindow_display(window);
    }

    sfRenderWindow_destroy(window);

    return 0;
}
```

Build CSFML from source:

`cd ../CSFML-2.5.1-sources`

`mkdir build`

`cd build`


try this option to build it in the install directory. 

`cmake .. -DCMAKE_INSTALL_PREFIX=../install`

This is a custom directory, if this causes issues, then try again with 

`cmake ..`

`make`

`make install`

If you get an error like the following

```
-- Installing: /Library/Frameworks/freetype.framework
CMake Error at cmake_install.cmake:77 (file):
  file INSTALL cannot make directory
  "/Library/Frameworks/freetype.framework": Permission denied.
```

Then run `sudo make install`

Return to the `csfml-cmake-sources-testing` directory

CMakeLists.txt in `csfml-cmake-sources-testing` should have the following

```m
cmake_minimum_required(VERSION 3.10)
project(sfml_cmake_sources_static_testing)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(SFML_DIR "../SFML-2.5.1-sources/build")

find_package(SFML 2.5.1 COMPONENTS graphics window audio network system REQUIRED)

add_executable(sfml_cmake_sources_static_testing main.cpp)

target_link_libraries(sfml_cmake_sources_static_testing PRIVATE sfml-graphics sfml-window sfml-audio sfml-network sfml-system)
```

`mkdir build`

`cd build`

`cmake ..`

`cmake --build .`

You should now find a file `csfml-cmake-sources-testing` in the main directory, run it with `./csfml_cmake_sources_testing`

# CSFML CMake Sources Static Testing 


