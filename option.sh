#!/usr/bin/env bash

readonly NO_SOURCE_SETUP=1
readonly SETUP_TERMINALS_APT=1
readonly SETUP_TERMINALS_GIT=1
readonly SETUP_TERMINALS_ZSH=1
readonly SETUP_TERMINALS_OMZ=1
readonly SETUP_LANGS_CPP=1
readonly SETUP_LANGS_GOLANG=0
readonly SETUP_LANGS_RUST=1
readonly SETUP_LANGS_PYTHON=1

option::_() {
    local _="${NO_SOURCE_SETUP}"
    local _="${SETUP_TERMINALS_APT}"
    local _="${SETUP_TERMINALS_GIT}"
    local _="${SETUP_TERMINALS_ZSH}"
    local _="${SETUP_TERMINALS_OMZ}"
    local _="${SETUP_LANGS_CPP}"
    local _="${SETUP_LANGS_GOLANG}"
    local _="${SETUP_LANGS_RUST}"
    local _="${SETUP_LANGS_PYTHON}"
}
