#!/usr/bin/env bash

langs::cpp::install() {
    sudo apt-get install build-essential -y
}

langs::cpp::install_gdb() {
    sudo apt-get install gdb -y
}

langs::cpp::install_cmake() {
    sudo apt-get install cmake -y
}

langs::cpp::setup() {
    if [ -z "$(command -v g++)" ]; then
        langs::cpp::install
    fi

    if [ -z "$(command -v gdb)" ]; then
        langs::cpp::install_gdb
    fi

    if [ -z "$(command -v cmake)" ]; then
        langs::cpp::install_cmake
    fi
}
