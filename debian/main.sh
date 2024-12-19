#!/usr/bin/env bash

set -e

export ENABLE_VSCODE_EXTENSIONS="${ENABLE_VSCODE_EXTENSIONS:-"0"}"
SETUP_DIR="${SETUP_DIR:-"/tmp/setup_env"}"
GIT_REPO="${GIT_REPO:-"https://github.com/acathe/setup_env.git"}"
_BRANCH="${_BRANCH:-"master"}"

download_setup_env() {
    if [ -d "${SETUP_DIR}" ]; then
        return 0
    fi

    if [ -z "$(command -v git)" ]; then
        sudo apt-get update -qq
        sudo apt-get install git -y -qq
    fi

    git clone --depth 1 --single-branch --branch "${_BRANCH}" "${GIT_REPO}" "${SETUP_DIR}"
}

default_enable_pkg() {
    # 默认启用的包，如果需要禁用，需要在环境变量中设置 DISABLE_XXX=1

    declare -A _enable_pkg=(
        ["DISABLE_GIT"]="debian/terminal/git.sh"
        ["DISABLE_ZSH"]="debian/terminal/zsh.sh"
        ["DISABLE_OMZ"]="debian/terminal/omz.sh"
    )

    for key in "${!_enable_pkg[@]}"; do
        if [[ "${!key}" == "1" ]]; then
            continue
        fi

        if [ -f "${SETUP_DIR}/${_enable_pkg[${key}]}" ]; then
            bash "${SETUP_DIR}/${_enable_pkg[${key}]}"
        fi
    done
}

default_disable_pkg() {
    # 默认禁用的包，如果需要启用，需要在环境变量中设置 ENABLE_XXX=1

    declare -A _disable_pkg=(
        ["ENABLE_CPP"]="debian/lang/cpp.sh"
        ["ENABLE_GO"]="debian/lang/go.sh"
        ["ENABLE_RUST"]="debian/lang/rust.sh"
        ["ENABLE_PYTHON"]="debian/lang/python.sh"
    )

    for key in "${!_disable_pkg[@]}"; do
        if [[ "${!key}" != "1" ]]; then
            continue
        fi

        if [ -f "${SETUP_DIR}/${_disable_pkg[${key}]}" ]; then
            bash "${SETUP_DIR}/${_disable_pkg[${key}]}"
        fi
    done
}

main() {
    sudo apt-get update -qq
    sudo apt-get upgrade -y -qq

    download_setup_env
    default_enable_pkg
    default_disable_pkg

    sudo apt-get autoremove -y
    sudo apt-get clean
}

main "$@"
