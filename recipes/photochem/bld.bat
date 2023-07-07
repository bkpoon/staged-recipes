setlocal EnableDelayedExpansion

cd %SRC_DIR%

set "CMAKE_GENERATOR=NMake Makefiles"

if exist photochem-%PKG_VERSION%_withdata (
  cd photochem-%PKG_VERSION%_withdata
)

git apply %RECIPE_DIR%\cmake.patch

%PYTHON% -m pip install . -vv
