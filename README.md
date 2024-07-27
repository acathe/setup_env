# Setup Env

- [1. Quick Start](#1-quick-start)
- [2. Installation](#2-installation)
  - [2.1. APT](#21-apt)
  - [2.2. Zsh](#22-zsh)
  - [2.3. Oh-My-Zsh](#23-oh-my-zsh)
  - [2.4. Oh-My-Zsh Plugins](#24-oh-my-zsh-plugins)
  - [2.5. Git](#25-git)

## 1. Quick Start

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup/apt.sh")" &&
  bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup/zsh.sh")" &&
  bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup/omz.sh")" &&
  bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup/omz_plugins.sh")" &&
```

```bash
export ENABLE_CHINA_MIRROR=1 &&
  bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup/apt.sh")" &&
  bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup/zsh.sh")" &&
  bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup/omz.sh")" &&
  bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup/omz_plugins.sh")" &&
  unset ENABLE_CHINA_MIRROR
```

## 2. Installation

### 2.1. APT

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup/apt.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

### 2.2. Zsh

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup/zsh.sh")"
```

### 2.3. Oh-My-Zsh

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup/omz.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

### 2.4. Oh-My-Zsh Plugins

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup/omz_plugins.sh")"
```

### 2.5. Git

```bash
git config --global user.name "${your_name}" &&
  git config --global user.email "${your_email}" &&
  git config --global core.editor "code --wait"
```
