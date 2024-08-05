#!/usr/bin/env bash

set -e

# shellcheck source-path=../..
source "./debian/tools/tools.sh"

debian::langs::cpp::set_env() {
    debian::tools::install_gdb
    debian::tools::install_cmake
}

debian::langs::cpp::setup() {
    debian::tools::install_build_essential

    debian::langs::cpp::set_env
}
