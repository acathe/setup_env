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
    sed -i "/export PATH=\$HOME\/bin:\$HOME\/\.local\/bin:\/usr\/local\/bin:\$PATH/s/^# //" "${HOME}/.zshrc"
}

main() {
    install_zsh
    sync_etc_profile
    sync_home_profile
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi
