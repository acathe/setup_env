#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_LINUX_TERMINAL_OMZ_SH}" ]]; then
    return 0
else
    _SETUP_ENV_LINUX_TERMINAL_OMZ_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_LINUX_TERMINAL_OMZ_SH
fi

# shellcheck source=../util/apt.sh
source "${_SETUP_ENV_LINUX_TERMINAL_OMZ_SH}/../util/apt.sh"

omz::append_plugin() {
    local _plugins_name="${*}"

    if [ ! -f "${HOME}/.zshrc" ]; then
        return 1
    fi

    if [[ "${_plugins_name}" == *"/"* ]]; then
        return 1
    fi

    sed -i "/^plugins=(/s/)/ ${_plugins_name})/" "${HOME}/.zshrc"
}

omz::change_theme() {
    local _theme_name="${1}"

    if [ ! -f "${HOME}/.zshrc" ]; then
        return 1
    fi

    if [[ "${_theme_name}" == *":"* ]]; then
        return 1
    fi

    sed -i "s:^ZSH_THEME=\".*\":ZSH_THEME=\"${_theme_name}\":" "${HOME}/.zshrc"
}

omz::install() {
    apt::update
    apt::install "git" "curl"

    # 使用 RUNZSH="no" 来跳过执行 Zsh，防止中断安装脚本。
    # Ref. https://ohmyz.sh/#install
    RUNZSH="no" sh -c "$(curl --proto "=https" --tlsv1.2 -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh")"

    if [ -s "${HOME}/.zshrc.pre-oh-my-zsh" ]; then
        # 如果之前的 .zshrc 非空，则把 OMZ 的配置添加到后面。
        echo >>"${HOME}/.zshrc.pre-oh-my-zsh"
        cat "${HOME}/.zshrc" >>"${HOME}/.zshrc.pre-oh-my-zsh"
        mv "${HOME}/.zshrc.pre-oh-my-zsh" "${HOME}/.zshrc"
    elif [ -f "${HOME}/.zshrc.pre-oh-my-zsh" ]; then
        # 如果之前的 .zshrc 为空，则直接删除。
        rm "${HOME}/.zshrc.pre-oh-my-zsh"
    fi
}

omz::install_plugin() {
    if [ -z "$(command -v git)" ]; then
        echo "git is not installed." >&2
        return 1
    fi

    declare -A _plugin_repo=(
        ["gitignore"]=""
        ["z"]=""
        ["vscode"]=""
        ["ohmyzsh-full-autoupdate"]="https://github.com/Pilaton/OhMyZsh-full-autoupdate.git"   # Ref. https://github.com/Pilaton/OhMyZsh-full-autoupdate?tab=readme-ov-file#installing
        ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"             # Ref. https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
        ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git" # Ref. https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md/#Oh-my-zsh
    )

    for _plugin in "${!_plugin_repo[@]}"; do
        omz::append_plugin "${_plugin}"

        if [[ -z "${_plugin_repo[${_plugin}]}" ]]; then
            continue
        fi

        local _plugin_path="${ZSH_CUSTOM:-"${HOME}/.oh-my-zsh/custom"}/plugins/${_plugin}"
        if [ -d "${_plugin_path}" ]; then
            rm -rf "${_plugin_path}"
        fi

        git clone "${_plugin_repo[${_plugin}]}" "${_plugin_path}"
    done
}

omz::install_theme() {
    if [ -z "$(command -v git)" ]; then
        echo "git is not installed." >&2
        return 1
    fi

    # Ref. https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh
    local _theme_name="powerlevel10k"
    local _theme_repo="https://github.com/romkatv/powerlevel10k.git"

    local _theme_path="${ZSH_CUSTOM:-"${HOME}/.oh-my-zsh/custom"}/themes/${_theme_name}"
    if [ -d "${_theme_path}" ]; then
        rm -rf "${_theme_path}"
    fi

    git clone --depth=1 "${_theme_repo}" "${_theme_path}"
    omz::change_theme "${_theme_name}/${_theme_name}"
}

omz::remove_preshell() {
    # 安装 Oh-My-Zsh 后默认的 shell 会变成 Zsh，通过这个函数删除之前的 shell 配置。
    #
    # NOTE: 此函数只管默认 Zsh 后删除原 shell 配置，原 shell 配置同步在 zsh.sh 中进行。
    #

    if [ ! -f "${HOME}/.shell.pre-oh-my-zsh" ]; then
        return 0
    fi

    local _preshell
    _preshell="$(cat "${HOME}/.shell.pre-oh-my-zsh")"
    rm "${HOME}/.shell.pre-oh-my-zsh"

    if [[ "$(basename -- "${_preshell}")" != "bash" ]]; then
        return 0
    fi

    local _bash_files=(
        "${HOME}/.bash_profile"
        "${HOME}/.bash_login"
        "${HOME}/.bashrc"
        "${HOME}/.bash_logout"
    )

    for _file in "${_bash_files[@]}"; do
        if [ ! -f "${_file}" ]; then
            continue
        fi

        rm "${_file}"
    done
}

main() {
    omz::install
    omz::install_plugin
    omz::remove_preshell
}

if [[ "${0}" == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi
