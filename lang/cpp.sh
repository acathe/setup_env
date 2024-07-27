#!/usr/bin/env bash

set -e

main() {
    sudo apt-get update
    apt-get install build-essential gdb cmake -y
    sudo apt-get autoremove -y
    sudo apt-get clean
}

main "$@"
