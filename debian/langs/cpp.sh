#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/tools/tools.sh"

langs::cpp::set_env() {
    tools::install_gdb
    tools::install_cmake
}

langs::cpp::setup() {
    tools::install_build_essential

    langs::cpp::set_env
}
