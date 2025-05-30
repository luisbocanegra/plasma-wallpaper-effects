#!/bin/sh
if [ -d "build" ]; then
    rm -rf build
fi

# install plasmoid only
cmake -B build -S . -DCMAKE_INSTALL_PREFIX="$HOME/.local"
cmake --build build
cmake --install build
