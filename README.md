# Setup Env

- [1. Quick Start](#1-quick-start)
- [2. Oh My Zsh](#2-oh-my-zsh)
- [3. Homebrew](#3-homebrew)
- [4. Application](#4-application)

## 1. Quick Start

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/macos/master/setup.sh")"
```

You can also use `ENABLE_CHINA_MIRROR` to receive subsequent updates.

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

Restart the terminal to configure Powerlevel10k.

The script will download the fonts required for the Powerlevel10k theme into the `~/Downloads` directory.

You will need to install them manually and set them up in your terminal.

## 3. Homebrew

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/macos/master/tool/homebrew.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

## 4. Application

```bash
brew install --cask visual-studio-code orbstack
```

---

Orbstack can use a [Chinese mirror](https://dockerproxy.com).
