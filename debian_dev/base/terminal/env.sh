#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${_DEV_ENV_TERMINAL_ENV_SH}" ]]; then
    return 0
else
    _DEV_ENV_TERMINAL_ENV_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _DEV_ENV_TERMINAL_ENV_SH
fi

enable_proxy() {
    # shellcheck source=/dev/null
    source "${HOME}/.local/script.d/agent_baidu.sh"
    agent_baidu enable
}

set_gitconfig() {
    git config --global user.name "朱成锐"
    git config --global user.email "zhuchengrui01@baidu.com"
    git config --global core.editor "code --wait"
    git config --global url."https://zhuchengrui01:baidu2351_A@icode.baidu.com/".insteadOf \
        https://zhuchengrui01@icode.baidu.com/
    git config --global url."https://zhuchengrui01:baidu2351_A@icode.baidu.com/".insteadOf \
        ssh://zhuchengrui01@icode.baidu.com:8235/
}

install_omz() {
    RUNZSH="no" sh -c "$(curl -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh")"
    git clone "https://github.com/Pilaton/OhMyZsh-full-autoupdate.git" "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate"
    git clone "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    git clone --depth=1 "https://github.com/romkatv/powerlevel10k.git" "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k"

    sed -i "/^plugins=(/s/)/ gitignore z vscode ohmyzsh-full-autoupdate zsh-autosuggestions zsh-syntax-highlighting)/" "${HOME}/.zshrc"
    sed -i "s:^ZSH_THEME=\".*\":ZSH_THEME=\"powerlevel10k/powerlevel10k\":" "${HOME}/.zshrc"
}

sync_profile() {
    # sync /etc/profile to /etc/zsh/zprofile
    tee "/tmp/.profile.sync" <<EOF >"/dev/null"
# Sync "/etc/profile".
source "/etc/profile"

EOF
    cat "/etc/zsh/zprofile" >>"/tmp/.profile.sync"
    sudo mv "/tmp/.profile.sync" "/etc/zsh/zprofile"

    # sync ~/.profile to ~/.zprofile
    tee "${HOME}/.zprofile" <<EOF >"/dev/null"
# Sync "/etc/profile".
source "/etc/profile"
EOF

    # sync ~/.profile to ~/.zprofile
    tee "${HOME}/.zprofile" <<EOF >"/dev/null"
# set PATH so it includes user's private bin if it exists
if [ -d "\$HOME/.local/bin" ] ; then
    PATH="\$HOME/.local/bin:\$PATH"
fi
EOF

    rm "${HOME}/.shell.pre-oh-my-zsh"
    rm "${HOME}/.bashrc"
    rm "${HOME}/.bash_logout"
    rm "${HOME}/.profile"
}

set_proxy() {
    tee "/tmp/.zshrc" <<EOF >"/dev/null"
source "\${HOME}/.local/script.d/agent_baidu.sh"
agent_baidu enable

EOF
    cat "${HOME}/.zshrc" >>"/tmp/.zshrc"
    mv "/tmp/.zshrc" "${HOME}/.zshrc"
}

main() {
    sudo passwd work
    enable_proxy
    install_omz
    set_proxy # omz 会更新 zshrc，需要安装 omz 后再在 zshrc 中添加 proxy
    sync_profile
    zsh # 进入 zsh 配置 p10k
    rm -rf "${HOME}/env.sh"
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
    cd "${_DEV_ENV_TERMINAL_ENV_SH}"
    main "$@"
fi
