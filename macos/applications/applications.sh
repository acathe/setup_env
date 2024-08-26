#!/usr/bin/env bash

set -e

macos::applications::install_orbstack() {
    brew install --cask orbstack
}

macos::applications::install_vscode() {
    brew install --cask visual-studio-code
    brew install --cask font-fira-code
}

macos::applications::install_chatgpt() {
    brew install --cask chatgpt
}

macos::applications::install_utm() {
    brew install --cask utm
}
