#!/usr/bin/env bash

langs::cpp::install() {
    sudo apt-get update
    sudo apt-get install build-essential -y
    sudo apt-get autoremove -y
    sudo apt-get clean
}

langs::cpp::install_gdb() {
    sudo apt-get update
    sudo apt-get install gdb -y
    sudo apt-get autoremove -y
    sudo apt-get clean
}

langs::cpp::install_cmake() {
    sudo apt-get update
    sudo apt-get install cmake -y
    sudo apt-get autoremove -y
    sudo apt-get clean
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
