# Setup Env

- [1. Quick Start](#1-quick-start)
- [2. Oh My Zsh](#2-oh-my-zsh)
- [3. Homebrew](#3-homebrew)
- [4. Linux Env](#4-linux-env)

## 1. Quick Start

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/macos/master/setup.sh")"
```

```bash
ENABLE_CHINA_MIRROR=1 bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/macos/master/setup.sh")"
```

## 2. Oh My Zsh

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/macos/master/tool/omz.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

---

- [下载链接](https://ohmyz.sh/#install)
- [国内源](https://mirrors.tuna.tsinghua.edu.cn/help/ohmyzsh.git/#%E5%88%87%E6%8D%A2%E5%B7%B2%E6%9C%89%20ohmyzsh%20%E8%87%B3%E9%95%9C%E5%83%8F%E6%BA%90)
- 插件：
  - [自动补全](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)
  - [高亮](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md/#Oh-my-zsh)
  - [主题](https://github.com/romkatv/powerlevel10k#getting-started)

```bash
plugins=(z brew vscode zsh-autosuggestions zsh-syntax-highlighting)
```

## 3. Homebrew

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/macos/master/tool/homebrew.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

---

- [下载链接](https://brew.sh/zh-cn/)
- 国内源：
  - [Homebrew 镜像](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/)
  - [Homebrew-bottles 镜像](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/)

```bash
brew install --cask visual-studio-code
```

## 4. Linux Env

```bash
brew install --cask orbstack
```

- [国内源](https://dockerproxy.com)
