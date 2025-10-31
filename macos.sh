#!/usr/bin/env bash

set -euo pipefail

if [[ ! -d "/Library/Developer/CommandLineTools" ]]; then
    xcode-select --install
fi

BRANCH="${BRANCH:-master}"
tmpdir="$(mktemp -du "/tmp/setup_env.XXXXXX")"

git clone "https://github.com/acathe/setup-env.git" "$tmpdir" \
    --depth 1 \
    --single-branch \
    --branch "$BRANCH"

bash "$tmpdir/macos/main.sh"
