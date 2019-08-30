include(ExternalProject)

ExternalProject_Add(
    mongo-c-driver
    GIT_REPOSITORY "https://github.com/mongodb/mongo-c-driver.git"
    GIT_TAG ${MONGOC_DRIVER_VER}
    GIT_PROGRESS ON
    GIT_SHALLOW  ON
    
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX:PATH=${MONGO_DRIVERS_DIR}/mongo-c-driver 
        -DBSON_ROOT_DIR:PATH=${MONGO_DRIVERS_DIR}/mongo-c-driver 
        -DENABLE_TESTS:BOOL=OFF
        -DENABLE_STATIC:BOOL=OFF
        -DENABLE_EXAMPLES:BOOL=OFF
        -DENABLE_EXTRA_ALIGNMENT:BOOL=OFF   
        -DENABLE_SASL=SSPI
        -DENABLE_SSL=WINDOWS     
)

set(libmongoc-1.0_DIR ${MONGO_DRIVERS_DIR}/mongo-c-driver/lib/cmake/libmongoc-1.0/) #
set(libbson-1.0_DIR ${MONGO_DRIVERS_DIR}/mongo-c-driver/lib/cmake/libbson-1.0/) #

ExternalProject_Add(
    mongo-cxx-driver
    GIT_REPOSITORY "https://github.com/mongodb/mongo-cxx-driver.git"
    GIT_TAG ${MONGOCXX_DRIVER_VER}
    GIT_PROGRESS ON
    GIT_SHALLOW  ON
        
    CMAKE_ARGS 
        -DCMAKE_INSTALL_PREFIX:PATH=${MONGO_DRIVERS_DIR}/mongo-cxx-driver
        -DBUILD_SHARED_LIBS:BOOL=ON
        -DENABLE_TESTS:BOOL=OFF
        -DENABLE_EXAMPLES:BOOL=OFF
        -DBSONCXX_POLY_USE_BOOST:BOOL=ON
        -DBSONCXX_POLY_USE_MNMLSTC:BOOL=OFF
        -DBSONCXX_POLY_USE_STD:BOOL=OFF
        -DBOOST_ROOT:PATH=${BOOST_ROOT}
        -Dlibmongoc-1.0_DIR:PATH=${libmongoc-1.0_DIR}
        -Dlibbson-1.0_DIR:PATH=${libbson-1.0_DIR}
    DEPENDS
        mongo-c-driver
)
