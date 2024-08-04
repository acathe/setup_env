#!/usr/bin/env bash

tools::install_jq() {
    if [ -n "$(command -v jq)" ]; then
        return
    fi

    sudo apt-get install jq -y -qq
}

tools::install_curl() {
    if [ -n "$(command -v curl)" ]; then
        return
    fi

    sudo apt-get install curl -y -qq
}

tools::install_git() {
    if [ -n "$(command -v git)" ]; then
        return
    fi

    sudo apt-get install git -y -qq
}

tools::install_zsh() {
    if [ -n "$(command -v zsh)" ]; then
        return
    fi

    sudo apt-get install zsh -y -qq
}

tools::install_build_essential() {
    if [ -n "$(command -v g++)" ]; then
        return
    fi

    sudo apt-get install build-essential -y -qq
}

tools::install_gdb() {
    if [ -n "$(command -v gdb)" ]; then
        return
    fi

    sudo apt-get install gdb -y -qq
}

tools::install_cmake() {
    if [ -n "$(command -v cmake)" ]; then
        return
    fi

    sudo apt-get install cmake -y -qq
}

tools::install_python() {
    if [ -n "$(command -v python3)" ]; then
        return
    fi

    sudo apt-get install python3 -y -qq
}
