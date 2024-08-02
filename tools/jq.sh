#!/usr/bin/env bash

tools::jq::install() {
    sudo apt-get update
    sudo apt-get install jq -y
    sudo apt-get autoremove -y
    sudo apt-get clean
}
