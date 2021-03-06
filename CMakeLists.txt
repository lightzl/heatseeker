cmake_minimum_required (VERSION 2.8)
project ( heatseeker )

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=gnu++11 -Werror -Wfatal-errors")
SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} /usr/local/lib/cmake/)
SET(CMAKE_BUILD_TYPE Debug)

find_package( Threads )
find_package( OpenCV REQUIRED )
find_package( raspicam REQUIRED )

link_directories(
    /opt/vc/lib
    /usr/include
    /usr/lib/arm-linux-gnueabihf
)

set(RPi_LIBS
# Raspberry Pi - Broadcom
    libbcm_host.so
    libvcos.so
)

set(GL_LIBS
    GLESv2
    EGL
)

set(USB
    libusb-1.0.so
)

file(GLOB src *h *.cpp)

add_executable(${PROJECT_NAME}
    input.cpp
    main.cpp
    regular_camera.cpp
    thermal.cpp
    thermal_frame.cpp
)

file(
    COPY
    shaders/heastvertexshader.glsl
    shaders/ironlyfragmentshader.glsl
    shaders/mixedgrayscalefragmentshader.glsl
    shaders/mixedblendfragmentshader.glsl
    DESTINATION ${CMAKE_BINARY_DIR}
)

include_directories(
    /opt/vc/include
    /opt/vc/include/interface/vcos/pthreads
    /opt/vc/include/interface/vmcs_host/linux
    ${CMAKE_SOURCE_DIR}/utils
    ${CMAKE_SOURCE_DIR}/picam
)

add_subdirectory(utils)
add_subdirectory(picam)
add_subdirectory(GPIO)

target_link_libraries(${PROJECT_NAME} 
    ${OpenCV_LIBS}
    ${RPi_LIBS}
    ${GL_LIBS}
    ${USB}
    ${raspicam_CV_LIBS}
    ${CMAKE_THREAD_LIBS_INIT}
    utils
    picam
    gpio
)
