#!/usr/bin/env bash

set -ex

main() {
    sudo apt-get update
    sudo apt-get install build-essential gdb cmake -y
    sudo apt-get autoremove -y
    sudo apt-get clean
}

main "$@"
