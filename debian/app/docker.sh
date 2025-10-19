#!/usr/bin/env bash

set -euo pipefail

add_docker_repo() {
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
        | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
}

install_docker() {
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

add_docker_group() {
    if ! getent group docker > /dev/null 2>&1; then
        echo "docker group does not exist." >&2
        return 1
    fi

    sudo usermod -aG docker "$(whoami)"
}

main() {
    add_docker_repo
    install_docker
    add_docker_group
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi
