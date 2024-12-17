#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_LINUX_LANG_PYTHON_SH}" ]]; then
    return 0
else
    _SETUP_ENV_LINUX_LANG_PYTHON_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_LINUX_LANG_PYTHON_SH
fi

# shellcheck source=../util/apt.sh
source "${_SETUP_ENV_LINUX_LANG_PYTHON_SH}/../util/apt.sh"
# shellcheck source=../terminal/omz.sh
source "${_SETUP_ENV_LINUX_LANG_PYTHON_SH}/../terminal/omz.sh"

python::install() {
    apt::update
    apt::install "python3" "python3-pip" "python3-venv"
}

python::set_env() {
    omz::append_plugin "python"
}

main() {
    python::install
    python::set_env
}

if [[ "${0}" == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi
