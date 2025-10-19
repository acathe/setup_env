#!/usr/bin/env bash

set -euo pipefail

tmpdir="$(mktemp -du "/tmp/setup_env.XXXXXX")"

if [ ! -d "/Library/Developer/CommandLineTools" ]; then
    xcode-select --install
fi

if [[ -z ${_BRANCH} ]]; then
    _BRANCH="master"
fi

git clone --depth 1 --single-branch --branch "${_BRANCH}" "https://github.com/acathe/setup_env.git" "${tmpdir}"

bash "${tmpdir}/macos/main.sh"
