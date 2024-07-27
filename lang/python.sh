#!/usr/bin/env bash
#
# Respects the following environment variables:
#   ENABLE_CHINA_MIRROR -
#

set -ex

main() {
    sudo apt-get update
    sudo apt-get install python3 python3-pip -y
    sudo apt-get autoremove -y
    sudo apt-get clean

    python3 -m pip install --upgrade pip

    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/pypi/#%E8%AE%BE%E4%B8%BA%E9%BB%98%E8%AE%A4
        pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
    fi
}

main "$@"
