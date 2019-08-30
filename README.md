# Building mongo cxx driver using cmake

An example of how to compile a MongoDB cxx driver using CMake. Currently, the solution is only for Windows. After successful build drivers will be available in a drivers directory and mini-test program for driver testing in an install directory.

## Steps how to build drivers and test it

1. Download [boost c++ 1.70](https://www.boost.org/users/history/version_1_70_0.html) libraries and unzip to "C:/boost_1_70_0"

2. Create a build folder:
```
mkdir build && cd build
```

3. Generate project configuration files for Windows 64
```
cmake -G "Visual Studio 15 2017 Win64" .. # "-DCMAKE_BUILD_TYPE=Release" 
```

4. Build MongoDB C++ drivers:
```
cmake --build . # --config Release
```
After successfully build drivers will be in a drivers directory!

5. Additional, build and install test program executes:
```
cmake --build . --target install
```

6. Run the test program:
```
./install/test_mongocxx.exe
```

## Source
* http://mongocxx.org/mongocxx-v3/installation/
* http://mongoc.org/libmongoc/current/installing.html
* https://stackoverflow.com/questions/51717207/building-mongo-cxx-driver-using-cmake-externalproject-add
* https://github.com/dhandeo/cmake-mongo-cxx-driver
* https://cliutils.gitlab.io/modern-cmake/chapters/basics.html
* https://stackoverflow.com/questions/39598323/how-to-properly-link-libraries-with-cmake
* https://hackernoon.com/create-a-mongodb-sharded-cluster-with-ssl-enabled-dace56bc7a17
* https://medium.com/@rajanmaharjan/secure-your-mongodb-connections-ssl-tls-92e2addb3c89