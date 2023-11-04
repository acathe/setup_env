FROM docker/dev-environments-default:stable-1

SHELL ["/bin/zsh", "-c"]

ARG OS
ARG ARCH

# 时区
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Git
COPY ./files/root/.gitconfig /root/.gitconfig

# APT
COPY ./files/etc/apt/sources.list /etc/apt/sources.list
RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get autoremove &&\
    apt-get autoclean -y

# Zsh & Oh-My-Zsh & Powerlevel10k
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &&\
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &&\
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k &&\
    chsh -s /bin/zsh &&\
    source ~/.zshrc &&\
    omz update
COPY ./files/root/.p10k.zsh /root/.p10k.zsh
COPY ./files/root/.zshrc /root/.zshrc
RUN source ~/.zshrc &&\
    git -C $ZSH remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git &&\
    git -C $ZSH pull &&\
    omz update

# 基本编译组件 & C/C++
RUN apt-get update &&\
    apt-get install build-essential gdb cmake -y &&\
    apt-get autoremove -y &&\
    apt-get autoclean -y

# Golang
ARG GO_VERSION
RUN curl --proto '=https' --tlsv1.2 -sSfOL https://golang.google.cn/dl/go${GO_VERSION}.${OS}-${ARCH}.tar.gz &&\
    rm -rf /usr/local/go &&\
    tar -C /usr/local -xzf go${GO_VERSION}.${OS}-${ARCH}.tar.gz &&\
    rm go${GO_VERSION}.${OS}-${ARCH}.tar.gz

# Rust
RUN source ~/.zshrc &&\
    curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh -s -- -y
COPY ./files/root/.cargo/config /root/.cargo/config

# Python
RUN apt-get update &&\
    apt-get install python3-pip -y &&\
    pip install --upgrade pip &&\
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple &&\
    apt-get autoremove -y &&\
    apt-get autoclean -y
