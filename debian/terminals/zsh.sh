#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/tools/tools.sh"

terminals::zsh::_append_zshenv() {
    local _zshenv="${1}" _profile="${2}"

    if [ ! -f "${_profile}" ]; then
        return
    fi

    if [[ "${_profile}" =~ ^"${HOME}"/ ]]; then
        _profile="${_profile/"${HOME}"/"\${HOME}"}"
    fi

    sudo tee -a "${_zshenv}" <<EOF >/dev/null
if [[ "${-}" == *"i"* ]]; then
    . "${_profile}"
fi
EOF
}

terminals::zsh::sync_profile() {
    if [ -z "$(command -v zsh)" ]; then
        return 1
    fi

    terminals::zsh::_append_zshenv "/etc/zsh/zshenv" "/etc/profile"
    terminals::zsh::_append_zshenv "${HOME}/.zshenv" "${HOME}/.profile"
}

terminals::zsh::setup() {
    tools::install_zsh

    terminals::zsh::sync_profile
}
