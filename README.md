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
  - [3.4. VSCode Plugins](#34-vscode-plugins)
    - [3.4.1. General](#341-general)
    - [3.4.2. C/C++](#342-cc)
    - [3.4.3. Bash/Shell](#343-bashshell)
    - [3.4.4. Rust](#344-rust)
    - [3.4.5. Git/Github](#345-gitgithub)
    - [3.4.6. Markdown](#346-markdown)
    - [3.4.7. Python](#347-python)
    - [3.4.8. Other](#348-other)
- [4. TODO](#4-todo)

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

|      Option      | Terminals |
| :--------------: | :-------: |
|  `DISABLE_GIT`   |    Git    |
| `GIT_USER_NAME`  |     ^     |
| `GIT_USER_EMAIL` |     ^     |
|  `DISABLE_ZSH`   |    Zsh    |
|  `DISABLE_OMZ`   | Oh-My-Zsh |

### 2.2. Langs

By default, the following applications are not installed.

You can use the `ENABLE` parameter to install them.

|     Option      | Langs  |
| :-------------: | :----: |
|  `ENABLE_CPP`   |  C++   |
| `ENABLE_GOLANG` | Golang |
|  `ENABLE_RUST`  |  Rust  |
| `ENABLE_PYTHON` | Python |

## 3. MacOS

### 3.1. Terminals

By default, the following applications are installed.

You can use the `DISABLE` parameter to turn them off.

|       Option       | Terminals |
| :----------------: | :-------: |
| `DISABLE_HOMEBREW` | HomeBrew  |
|   `DISABLE_OMZ`    | Oh-My-Zsh |

### 3.2. Applications

By default, the following applications are not installed.

You can use the `ENABLE` parameter to install them.

|      Option       |    Applications    |
| :---------------: | :----------------: |
| `ENABLE_ORBSTACK` |      Orbstack      |
|  `ENABLE_VSCODE`  | Visual Studio Code |
| `ENABLE_CHATGPT`  |      ChatGPT       |
|   `ENABLE_UTM`    |        UTM         |

### 3.3. Powerlevel10k

Restart the terminal to configure Powerlevel10k.

The script will download the fonts required for the Powerlevel10k theme.

You will need to set them up in your terminal manually.

### 3.4. VSCode Plugins

#### 3.4.1. General

|                                                              Plugins                                                              |
| :-------------------------------------------------------------------------------------------------------------------------------: |
|                  [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)                  |
| [Remote - SSH: Editing Configuration Files](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh-edit) |
|                 [Remote Explorer](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-explorer)                  |
|                       [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)                        |
|                  [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)                   |
|          [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)          |
|            [Better Comments Next](https://marketplace.visualstudio.com/items?itemName=EdwinHuiSH.better-comments-next)            |
|                      [change-case](https://marketplace.visualstudio.com/items?itemName=wmaurer.change-case)                       |
|            [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense)            |
|               [Ligatures Limited](https://marketplace.visualstudio.com/items?itemName=kshetline.ligatures-limited)                |

#### 3.4.2. C/C++

|                                         Plugins                                          |
| :--------------------------------------------------------------------------------------: |
|     [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)      |
|         [CMake](https://marketplace.visualstudio.com/items?itemName=twxs.cmake)          |
| [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools) |

#### 3.4.3. Bash/Shell

|                                            Plugins                                            |
| :-------------------------------------------------------------------------------------------: |
| [Bash IDE](https://marketplace.visualstudio.com/items?itemName=mads-hartmann.bash-ide-vscode) |
|        [shellman](https://marketplace.visualstudio.com/items?itemName=Remisa.shellman)        |
|    [ShellCheck](https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck)     |
| [shell-format](https://marketplace.visualstudio.com/items?itemName=foxundermoon.shell-format) |

#### 3.4.4. Rust

|                                             Plugins                                              |
| :----------------------------------------------------------------------------------------------: |
|   [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)   |
|         [Dependi](https://marketplace.visualstudio.com/items?itemName=fill-labs.dependi)         |
| [Even Better TOML](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml) |

#### 3.4.5. Git/Github

|                                                    Plugins                                                    |
| :-----------------------------------------------------------------------------------------------------------: |
|       [GitLens — Git supercharged](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)       |
| [GitHub Pull Requests](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github) |

#### 3.4.6. Markdown

|                                                Plugins                                                |
| :---------------------------------------------------------------------------------------------------: |
| [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one) |
|  [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)   |

#### 3.4.7. Python

|                                                          Plugins                                                          |
| :-----------------------------------------------------------------------------------------------------------------------: |
|                      [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)                       |
|                  [Pylance](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance)                  |
|                      [Pylint](https://marketplace.visualstudio.com/items?itemName=ms-python.pylint)                       |
|                 [Python Debugger](https://marketplace.visualstudio.com/items?itemName=ms-python.debugpy)                  |
| [Python Environment Manager](https://marketplace.visualstudio.com/items?itemName=donjayamanne.python-environment-manager) |
|             [Black Formatter](https://marketplace.visualstudio.com/items?itemName=ms-python.black-formatter)              |
| [autoDocstring - Python Docstring Generator](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring) |
|             [Python Snippets 3](https://marketplace.visualstudio.com/items?itemName=EricSia.pythonsnippets3)              |

#### 3.4.8. Other

|                                    Plugins                                     |
| :----------------------------------------------------------------------------: |
| [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) |

## 4. TODO

- [ ] Support retry on failure, not restart.
- [ ] Support syncing VSCode settings.
