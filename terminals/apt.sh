#!/usr/bin/env bash

# shellcheck source-path=..
source "./utils/utils.sh"

terminals::apt::replace_mirror() {
    if [ ! -f "/etc/os-release" ]; then
        echo "Error: /etc/os-release not found." >&2
        return 1
    fi

    local id version_codename
    id="$(utils::load_vars_from_file "/etc/os-release" "ID")"
    version_codename="$(utils::load_vars_from_file "/etc/os-release" "VERSION_CODENAME")"

    if [[ "${id}" != "debian" ]] || [[ "${version_codename}" != "bookworm" ]]; then
        echo "Error: Unsupported OS." >&2
        return 1
    fi

    # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/debian/
    sudo tee "/etc/apt/sources.list" <<EOF
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware

# 以下安全更新软件源包含了官方源与镜像站配置，如有需要可自行修改注释切换
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
EOF
}

terminals::apt::upgrade() {
    sudo apt-get update
    sudo apt-get upgrade -y
}

terminals::apt::setup() {
    if [ -n "${ENABLE_CHINA_MIRROR}" ]; then
        terminals::apt::replace_mirror
    fi

    terminals::apt::upgrade
}
