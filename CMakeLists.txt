cmake_minimum_required(VERSION 3.12)

set(CMAKE_CXX_STANDARD 11) 

project(mongo-cxx-drivers LANGUAGES CXX)

# set mongo-c driver version, which are necessery for mongo-cxx drivers
set(MONGOC_DRIVER_VER "1.13.1")

# set mongodb drivers directory
set(MONGO_DRIVERS_DIR ${CMAKE_SOURCE_DIR}/drivers)

# set mongo-cxx driver version
set(MONGOCXX_DRIVER_VER "r3.4.0")

# Set boost c++ libraries path
set(BOOST_ROOT "C:/boost_1_70_0")

# Varibles for connection to MongoDB
# set path to ca file
set(CA_FILE_PATH "C:/mongossl/rootCA.pem")

# set path to pem file
set(PEM_FILE_PATH "C:/mongossl/mongodb.pem")

#set connection URI with ssl flag true
set(CONNECTION_URI "mongodb://localhost:27017/?ssl=true")

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

# Find the mongodb drivers
find_package(MongoDB REQUIRED)

configure_file("${PROJECT_SOURCE_DIR}/config.h.in" "${PROJECT_SOURCE_DIR}/config.h")

include_directories(${MONGO_DRIVERS_DIR}/mongo-cxx-driver/include/bsoncxx/v_noabi                    
                    ${MONGO_DRIVERS_DIR}/mongo-cxx-driver/include/mongocxx/v_noabi
                    ${MONGO_DRIVERS_DIR}/mongo-c-driver/include/libbson-1.0
                    ${MONGO_DRIVERS_DIR}/mongo-c-driver/include/libmongoc-1.0
                    ${BOOST_ROOT})

# Populate a CMake variable with the sources
add_executable(test_mongocxx config.h 
                             main.cpp)

target_link_libraries(test_mongocxx PUBLIC ${MONGO_DRIVERS_DIR}/mongo-c-driver/lib/bson-1.0.lib
                                           ${MONGO_DRIVERS_DIR}/mongo-c-driver/lib/mongoc-1.0.lib
                                           ${MONGO_DRIVERS_DIR}/mongo-cxx-driver/lib/bsoncxx.lib
                                           ${MONGO_DRIVERS_DIR}/mongo-cxx-driver/lib/mongocxx.lib)

                                           
if(WIN32)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_LIST_DIR}/install" CACHE STRING "Install path prefix, prepended onto install directories" FORCE)

    install(FILES ${MONGO_DRIVERS_DIR}/mongo-c-driver/bin/libbson-1.0.dll
                  ${MONGO_DRIVERS_DIR}/mongo-c-driver/bin/libmongoc-1.0.dll  
                  ${MONGO_DRIVERS_DIR}/mongo-cxx-driver/bin/bsoncxx.dll
                  ${MONGO_DRIVERS_DIR}/mongo-cxx-driver/bin/mongocxx.dll
                  ${CMAKE_BINARY_DIR}/Debug/test_mongocxx.exe
            DESTINATION ${CMAKE_INSTALL_PREFIX})

endif()                                             
