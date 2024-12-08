#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_DEBIAN_TERMINAL_GH_SH}" ]]; then
    return 0
else
    _SETUP_ENV_DEBIAN_TERMINAL_GH_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_DEBIAN_TERMINAL_GH_SH
    cd "${_SETUP_ENV_DEBIAN_TERMINAL_GH_SH}"
fi

source "../util/apt.sh"

terminal::gh::add_apt_source() {
    util::apt::install "wget"

    # Ref. https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian-ubuntu-linux-raspberry-pi-os-apt
    sudo mkdir -p -m 755 /etc/apt/keyrings
    wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
    sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
    sudo apt update
}

terminal::gh::set_env() {
    # Ref. https://docs.github.com/zh/copilot/managing-copilot/configure-personal-settings/installing-github-copilot-in-the-cli
    gh auth login
}

terminal::gh::install_extension() {
    # Ref. https://docs.github.com/zh/copilot/managing-copilot/configure-personal-settings/installing-github-copilot-in-the-cli
    gh extension install github/gh-copilot

    if [ -s "${HOME}/.zshrc" ]; then
        echo >>"${HOME}/.zshrc"
    fi

    echo "# Github Copilot" >>"${HOME}/.zshrc"

    # Ref. https://docs.github.com/zh/copilot/managing-copilot/configure-personal-settings/configuring-github-copilot-in-the-cli
    echo "eval \"$(gh copilot alias -- zsh)\"" >>~/.zshrc
}

terminal::gh::update_extension() {
    gh extension upgrade github/gh-copilot
}

terminal::gh() {
    terminal::gh::add_apt_source
    util::apt::install "gh"
    terminal::gh::set_env
}
