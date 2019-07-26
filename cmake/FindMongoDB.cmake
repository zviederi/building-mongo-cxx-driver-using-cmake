include(ExternalProject)

ExternalProject_Add(
    mongo-c-driver
    GIT_REPOSITORY "https://github.com/mongodb/mongo-c-driver.git"
    GIT_TAG "1.13.1"
    GIT_PROGRESS ON
    GIT_SHALLOW  ON
    
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_SOURCE_DIR}/thirdparty/mongo-c-driver 
        -DBSON_ROOT_DIR:PATH=${CMAKE_SOURCE_DIR}/thirdparty/mongo-c-driver 
        -DENABLE_TESTS:BOOL=OFF
        -DENABLE_STATIC:BOOL=OFF
        -DENABLE_EXAMPLES:BOOL=OFF
        -DENABLE_EXTRA_ALIGNMENT:BOOL=OFF   
        -DENABLE_SSL=WINDOWS     
)

set(libmongoc-1.0_DIR ${CMAKE_SOURCE_DIR}/thirdparty/mongo-c-driver/lib/cmake/libmongoc-1.0/) #
set(libbson-1.0_DIR ${CMAKE_SOURCE_DIR}/thirdparty/mongo-c-driver/lib/cmake/libbson-1.0/) #

ExternalProject_Add(
    mongo-cxx-driver
    GIT_REPOSITORY "https://github.com/mongodb/mongo-cxx-driver.git"
    GIT_TAG "r3.4.0"
    GIT_PROGRESS ON
    GIT_SHALLOW  ON
        
    CMAKE_ARGS 
        -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_SOURCE_DIR}/thirdparty/mongo-cxx-driver
        -DBUILD_SHARED_LIBS:BOOL=ON
        -DENABLE_TESTS:BOOL=OFF
        -DENABLE_EXAMPLES:BOOL=OFF
        -DBSONCXX_POLY_USE_BOOST:BOOL=ON
        -DBSONCXX_POLY_USE_MNMLSTC:BOOL=OFF
        -DBSONCXX_POLY_USE_STD:BOOL=OFF
        -DBOOST_ROOT:PATH=${BOOST_ROOT}
        # -DLIBBSON_DIR:PATH=${CMAKE_SOURCE_DIR}/thirdparty/mongo-c-driver/
        # -DLIBMONGOC_DIR=${CMAKE_SOURCE_DIR}/thirdparty/mongo-c-driver
        -Dlibmongoc-1.0_DIR:PATH=${libmongoc-1.0_DIR}
        -Dlibbson-1.0_DIR:PATH=${libbson-1.0_DIR}
    DEPENDS
        mongo-c-driver
)
