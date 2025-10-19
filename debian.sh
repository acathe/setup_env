#!/usr/bin/env bash

set -euo pipefail

if [ "$(id -u)" -eq 0 ]; then
    if [[ -z ${SUDO_USER} ]]; then
        echo "SUDO_USER not set." >&2
        exit 1
    fi

    if ! getent group sudo > /dev/null 2>&1; then
        echo "sudo group does not exist." >&2
        exit 1
    fi

    apt-get update
    apt-get install -y sudo

    usermod -aG sudo "${SUDO_USER}"

    exit 0
fi

if [ -z "$(command -v git)" ]; then
    sudo apt-get update
    sudo apt-get install -y git
fi

_BRANCH=${_BRANCH:-master}
tmpdir="$(mktemp -du "/tmp/setup_env.XXXXXX")"

git clone --depth 1 --single-branch --branch "${_BRANCH}" "https://github.com/acathe/setup_env.git" "${tmpdir}"

bash "${tmpdir}/debian/main.sh"
