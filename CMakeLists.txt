cmake_minimum_required(VERSION 3.12)

set(CMAKE_CXX_STANDARD 11) 

project(mongo-cxx-drivers LANGUAGES CXX)

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

# set mongo-c driver version, which are necessery for mongo-cxx drivers
set(MONGOC_DRIVER_VER "1.13.1")

# set mongo-cxx driver version
set(MONGOCXX_DRIVER_VER "r3.4.0")

# Set boost c++ libraries path
set(BOOST_ROOT "C:/boost_1_70_0")

# Find the mongodb drivers
find_package(MongoDB REQUIRED)

include_directories(${CMAKE_SOURCE_DIR}/thirdparty/mongo-cxx-driver/include/bsoncxx/v_noabi                    
                    ${CMAKE_SOURCE_DIR}/thirdparty/mongo-cxx-driver/include/mongocxx/v_noabi
                    ${CMAKE_SOURCE_DIR}/thirdparty/mongo-c-driver/include/libbson-1.0
                    ${CMAKE_SOURCE_DIR}/thirdparty/mongo-c-driver/include/libmongoc-1.0
                    ${BOOST_ROOT})


# Populate a CMake variable with the sources
add_executable(test_mongocxx main.cpp)

target_link_libraries(test_mongocxx PUBLIC ${CMAKE_SOURCE_DIR}/thirdparty/mongo-c-driver/lib/bson-1.0.lib
                                           ${CMAKE_SOURCE_DIR}/thirdparty/mongo-c-driver/lib/mongoc-1.0.lib
                                           ${CMAKE_SOURCE_DIR}/thirdparty/mongo-cxx-driver/lib/bsoncxx.lib
                                           ${CMAKE_SOURCE_DIR}/thirdparty/mongo-cxx-driver/lib/mongocxx.lib)

if(WIN32)
    add_custom_command(TARGET test_mongocxx POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/thirdparty/mongo-c-driver/bin/libbson-1.0.dll ${CMAKE_SOURCE_DIR}/build/Debug
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/thirdparty/mongo-c-driver/bin/libmongoc-1.0.dll ${CMAKE_SOURCE_DIR}/build/Debug 
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/thirdparty/mongo-cxx-driver/bin/bsoncxx.dll ${CMAKE_SOURCE_DIR}/build/Debug 
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/thirdparty/mongo-cxx-driver/bin/mongocxx.dll ${CMAKE_SOURCE_DIR}/build/Debug 
    COMMENT "Copying related dll" VERBATIM)
endif()                                             
