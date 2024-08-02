#!/usr/bin/env bash

readonly SETUP_TERMINALS_HOMEBREW=1
readonly SETUP_TERMINALS_GIT=1
readonly SETUP_TERMINALS_OMZ=1

option::_() {
    local _="${SETUP_TERMINALS_HOMEBREW}"
    local _="${SETUP_TERMINALS_GIT}"
    local _="${SETUP_TERMINALS_OMZ}"
}
