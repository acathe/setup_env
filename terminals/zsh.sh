#!/usr/bin/env bash

terminals::zsh::install() {
    sudo apt-get install zsh -y
}

terminals::zsh::_sync_from_bash() {
    local bash_config="${1}"
    local zsh_config="${2}"

    if [ ! -f "${bash_config}" ]; then
        return
    fi

    if [[ "${bash_config}" =~ ^"${HOME}"/ ]]; then
        bash_config="${bash_config/"${HOME}"/"\${HOME}"}"
    fi

    tee "${HOME}/.tmp.zsh" <<EOF
# Description: Sync from Bash.
# Zsh does not have the \`shopt\` command.
# This script defines an empty function to ensure compatibility with Zsh.
shopt() {}
source ${bash_config}
unset -f shopt
EOF

    if [ -f "${zsh_config}" ]; then
        echo >>"${HOME}/.tmp.zsh"
        cat "${zsh_config}" >>"${HOME}/.tmp.zsh"
    fi

    sudo mv "${HOME}/.tmp.zsh" "${zsh_config}"
}

terminals::zsh::sync_from_bash() {
    # bash profile
    terminals::zsh::_sync_from_bash "/etc/profile" "/etc/zsh/zprofile"
    if [ -f "${HOME}/.bash_profile" ]; then
        terminals::zsh::_sync_from_bash "${HOME}/.bash_profile" "${HOME}/.zprofile"
    elif [ -f "${HOME}/.bash_login" ]; then
        terminals::zsh::_sync_from_bash "${HOME}/.bash_login" "${HOME}/.zprofile"
    else
        terminals::zsh::_sync_from_bash "${HOME}/.profile" "${HOME}/.zprofile"
    fi

    # bashrc
    terminals::zsh::_sync_from_bash "/etc/bash.bashrc" "/etc/zsh/zshrc"
    terminals::zsh::_sync_from_bash "${HOME}/.bashrc" "${HOME}/.zshrc"

    # bash logout
    terminals::zsh::_sync_from_bash "${HOME}/.bash_logout" "${HOME}/.zlogout"
}

terminals::zsh::setup() {
    if [ -z "$(command -v zsh)" ]; then
        terminals::zsh::install
    fi

    if [[ "$(basename -- "${SHELL}")" == "bash" ]]; then
        terminals::zsh::sync_from_bash
    fi
}
