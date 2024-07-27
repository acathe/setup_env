#!/usr/bin/env bash
#
# Respects the following environment variables:
#   ENABLE_CHINA_MIRROR -
#

set -e

main() {
    sudo apt-get update &&
        apt-get install python3 python3-pip -y &&
        sudo apt-get autoremove -y &&
        sudo apt-get clean

    python3 -m pip install --upgrade pip

    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
}

main "$@"
