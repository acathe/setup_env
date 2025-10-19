#!/usr/bin/env bash

set -euo pipefail

install_zsh() {
    sudo apt-get update
    sudo apt-get install -y zsh
}

sync_etc_profile() {
    tmpfile="$(mktemp -u)"

    tee "${tmpfile}" > "/dev/null" << EOF
# Sync /etc/profile.
emulate sh -c "source /etc/profile"

$(cat "/etc/zsh/zprofile")
EOF

    sudo mv "${tmpfile}" "/etc/zsh/zprofile"
}

sync_home_profile() {
    tee "${HOME}/.zprofile" > "/dev/null" << EOF
# set PATH so it includes user's private bin if it exists
if [ -d "\${HOME}/bin" ] ; then
    PATH="\${HOME}/bin:\${PATH}"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "\${HOME}/.local/bin" ] ; then
    PATH="\${HOME}/.local/bin:\${PATH}"
fi
EOF
}

main() {
    install_zsh
    sync_etc_profile
    sync_home_profile
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi
