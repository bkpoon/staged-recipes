cmake %CMAKE_ARGS% --trace-expand -S . -B build -DCMAKE_INSTALL_PREFIX=%PREFIX%

cmake --build build
cmake --install build

ctest --test-dir build
