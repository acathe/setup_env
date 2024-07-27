# Setup Env

- [1. Quick Start](#1-quick-start)
- [2. Terminal](#2-terminal)
  - [2.1. APT](#21-apt)
  - [2.2. Zsh](#22-zsh)
  - [2.3. Oh-My-Zsh](#23-oh-my-zsh)
  - [2.4. Oh-My-Zsh Plugins](#24-oh-my-zsh-plugins)
  - [2.5. Git](#25-git)
- [3. Lang](#3-lang)
  - [3.1. Cpp](#31-cpp)
  - [3.2. Golang](#32-golang)
  - [3.3. Rust](#33-rust)
  - [3.4. Python](#34-python)

## 1. Quick Start

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup.sh")"
```

```bash
ENABLE_CHINA_MIRROR=1 bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup.sh")"
```

## 2. Terminal

### 2.1. APT

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setups/apt.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

### 2.2. Zsh

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setups/zsh.sh")"
```

### 2.3. Oh-My-Zsh

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setups/omz.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

### 2.4. Oh-My-Zsh Plugins

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setups/omz_plugins.sh")"
```

### 2.5. Git

```bash
git config --global user.name "${your_name}" &&
  git config --global user.email "${your_email}" &&
  git config --global core.editor "code --wait"
```

## 3. Lang

### 3.1. Cpp

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/lang/cpp.sh")"
```

### 3.2. Golang

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/lang/golang.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

### 3.3. Rust

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/lang/rust.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

### 3.4. Python

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/lang/python.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |
