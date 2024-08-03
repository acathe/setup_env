# Setup Env

- [1. Quick Start](#1-quick-start)
  - [1.1. Debian](#11-debian)
  - [1.2. MacOS](#12-macos)
- [2. Debian](#2-debian)
  - [2.1. Terminals](#21-terminals)
  - [2.2. Langs](#22-langs)
- [3. MacOS](#3-macos)
  - [3.1. Terminals](#31-terminals)
  - [3.2. Powerlevel10k](#32-powerlevel10k)
  - [3.3. Application](#33-application)

## 1. Quick Start

### 1.1. Debian

```bash
GIT_USER_NAME=${your_name} GIT_USER_EMAIL=${your_email} bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/master/debian.sh")"
```

```bash
ENABLE_CHINA_MIRROR=1 GIT_USER_NAME=${your_name} GIT_USER_EMAIL=${your_email} bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/master/debian.sh")"
```

### 1.2. MacOS

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/master/macos.sh")"
```

```bash
ENABLE_CHINA_MIRROR=1 bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/master/macos.sh")"
```

## 2. Debian

### 2.1. Terminals

| Install | note. |
| :-: | :- |
| APT | Use Tsinghua Mirror. |
| Git | |
| Zsh | |
| Oh-My-Zsh | Use Tsinghua Mirror. |

### 2.2. Langs

| Install | note. |
| :-: | :- |
| C++ | |
| Golang | Default disable. |
| Rust | Use Tsinghua Mirror. |
| Python | Use Tsinghua Mirror. |

## 3. MacOS

### 3.1. Terminals

| Install | note. |
| :-: | :- |
| HomeBrew | Use Tsinghua Mirror. |
| Git | |
| Oh-My-Zsh | Use Tsinghua Mirror. |

### 3.2. Powerlevel10k

Restart the terminal to configure Powerlevel10k.

The script will download the fonts required for the Powerlevel10k theme into the `~/Downloads` directory.

You will need to install them manually and set them up in your terminal.

### 3.3. Application

```bash
brew install --cask visual-studio-code orbstack
```

Orbstack can use a [Chinese mirror](https://dockerproxy.com).
