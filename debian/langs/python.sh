#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/tools/tools.sh"
# shellcheck source-path=../..
source "./debian/utils/utils.sh"

langs::python::set_env() {
    sudo apt-get install python3-pip -y -qq
    sudo apt-get install python3-venv -y -qq

    utils::append_omz_plugins python
}

langs::python::setup() {
    tools::install_python

    langs::python::set_env
}
