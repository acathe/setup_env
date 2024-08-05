#!/usr/bin/env bash

set -e

# shellcheck source-path=../..
source "./debian/tools/tools.sh"
# shellcheck source-path=../..
source "./debian/utils/utils.sh"

debian::langs::python::set_env() {
    sudo apt-get install python3-pip -y -qq
    sudo apt-get install python3-venv -y -qq

    debian::utils::append_omz_plugins python
}

debian::langs::python::setup() {
    debian::tools::install_python

    debian::langs::python::set_env
}
