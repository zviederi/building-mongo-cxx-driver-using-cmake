# Building mongo cxx driver using cmake

An example of how to compile MongoDB cxx driver using CMake. Currently, the solution is tested only for Windows. After successful build drivers will be available in a thirdparty directory and mini mongo test application for testing in a build/Debug|Release directory.

## How to build

Download [boost c++ 1.70](https://www.boost.org/users/history/version_1_70_0.html) libraries and unzip to "C:/boost_1_70_0"

Commands to build driver:
```
mkdir build && cd build
cmake -G "Visual Studio 15 2017 Win64" .. # "-DCMAKE_BUILD_TYPE=Release" 
cmake --build . # --config Release
```

## Source
* http://mongocxx.org/mongocxx-v3/installation/
* http://mongoc.org/libmongoc/current/installing.html
* https://stackoverflow.com/questions/51717207/building-mongo-cxx-driver-using-cmake-externalproject-add
* https://github.com/dhandeo/cmake-mongo-cxx-driver
* https://cliutils.gitlab.io/modern-cmake/chapters/basics.html
* https://stackoverflow.com/questions/39598323/how-to-properly-link-libraries-with-cmake

## Author Information
------------------

* [Ēriks Zviedrāns](mailto:eriks.zviedrans@gmail.com)
