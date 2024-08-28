#!/usr/bin/env bash

set -e

# shellcheck source-path=../..
source "./debian/tools/tools.sh"

debian::langs::cpp::set_env() {
    debian::tools::install_gdb
    debian::tools::install_cmake
}

debian::langs::cpp() {
    debian::langs::cpp::set_env
}
