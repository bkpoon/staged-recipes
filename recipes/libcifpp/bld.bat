cmake %CMAKE_ARGS% --trace-expand -S . -B build ^
  -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
  -DBUILD_SHARED_LIBS=ON

REM cmake always creates a Debug build
REM cmake --build build --config Release
cd build
msbuild libcifpp.sln /property:Configuration=Release
cd ..
cmake --install build

ctest --output-on-failure --test-dir build -C Release
