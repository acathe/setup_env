# Setup Env

- [1. Quick Start](#1-quick-start)
  - [1.1. Debian](#11-debian)
  - [1.2. MacOS](#12-macos)
- [2. Debian](#2-debian)
  - [2.1. Terminals](#21-terminals)
  - [2.2. Langs](#22-langs)
- [3. MacOS](#3-macos)
  - [3.1. Terminals](#31-terminals)
  - [3.2. Applications](#32-applications)
  - [3.3. Powerlevel10k](#33-powerlevel10k)

## 1. Quick Start

### 1.1. Debian

```bash
GIT_USER_NAME=${your_name} GIT_USER_EMAIL=${your_email} bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/master/debian.sh")"
```

### 1.2. MacOS

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/master/macos.sh")"
```

## 2. Debian

### 2.1. Terminals

By default, the following applications are installed.

You can use the `DISABLE` parameter to turn them off.

| Option | Terminals |
| :-: | :-: |
| `DISABLE_GIT` | Git |
| `GIT_USER_NAME` | ⬆️ |
| `GIT_USER_EMAIL` | ⬆️ |
| `DISABLE_ZSH` | Zsh |
| `DISABLE_OMZ` | Oh-My-Zsh |

### 2.2. Langs

By default, the following applications are not installed.

You can use the `ENABLE` parameter to install them.

| Option | Langs |
| :-: | :-: |
| `ENABLE_CPP` | C++ |
| `ENABLE_GOLANG` | Golang |
| `ENABLE_RUST` | Rust |
| `ENABLE_PYTHON` | Python |

## 3. MacOS

### 3.1. Terminals

By default, the following applications are installed.

You can use the `DISABLE` parameter to turn them off.

| Option | Terminals |
| :-: | :-: |
| `DISABLE_HOMEBREW` | HomeBrew |
| `DISABLE_OMZ` | Oh-My-Zsh |

### 3.2. Applications

By default, the following applications are not installed.

You can use the `ENABLE` parameter to install them.

| Option | Applications |
| :-: | :-: |
| `ENABLE_ORBSTACK` | Orbstack |
| `ENABLE_VSCODE` | Visual Studio Code |
| `ENABLE_CHATGPT` | ChatGPT |
| `ENABLE_UTM` | UTM |

### 3.3. Powerlevel10k

Restart the terminal to configure Powerlevel10k.

The script will download the fonts required for the Powerlevel10k theme.

You will need to set them up in your terminal manually.
