@echo on

mkdir build
cd build

cmake %CMAKE_ARGS% ..
cmake --build . --config Release
cmake --install . --config Release
