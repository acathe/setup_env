#!/usr/bin/env bash

langs::python::install() {
    sudo apt-get update
    sudo apt-get install python3 -y
    sudo apt-get autoremove -y
    sudo apt-get clean
}

langs::python::install_venv() {
    sudo apt-get update
    sudo apt-get install python3-venv -y
    sudo apt-get autoremove -y
    sudo apt-get clean
}

langs::python::install_pip() {
    sudo apt-get update
    sudo apt-get install python3-pip -y
    sudo apt-get autoremove -y
    sudo apt-get clean

    if [ -n "${ENABLE_CHINA_MIRROR}" ]; then
        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/pypi/#%E8%AE%BE%E4%B8%BA%E9%BB%98%E8%AE%A4
        pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
    fi
}

langs::python::set_env() {
    sed -i '/^plugins=(/ s/)/ python)/' "${HOME}/.zshrc"
}

langs::python::setup() {
    if [ -z "$(command -v python3)" ]; then
        langs::python::install
    fi

    langs::python::install_venv
    langs::python::install_pip
    langs::python::set_env
}
