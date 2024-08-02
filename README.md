# Setup Env

- [1. Quick Start](#1-quick-start)
- [2. Tools](#2-tools)
  - [2.1. APT](#21-apt)
  - [2.2. Zsh](#22-zsh)
  - [2.3. Oh-My-Zsh](#23-oh-my-zsh)
  - [2.4. Git](#24-git)
- [3. Langs](#3-langs)
  - [3.1. Cpp](#31-cpp)
  - [3.2. Golang](#32-golang)
  - [3.3. Rust](#33-rust)
  - [3.4. Python](#34-python)

## 1. Quick Start

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup.sh")"
```

You can also use `ENABLE_CHINA_MIRROR` to receive subsequent updates from Chinese mirrors.

```bash
ENABLE_CHINA_MIRROR=1 bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/setup.sh")"
```

Please note that it will not configure Golang and Git for you.

However, there are specific configuration scripts for them below that you can use directly.

## 2. Tools

### 2.1. APT

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/tools/apt.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

### 2.2. Zsh

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/tools/zsh.sh")"
```

### 2.3. Oh-My-Zsh

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/tools/omz.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

### 2.4. Git

```bash
git config --global user.name "${your_name}" &&
  git config --global user.email "${your_email}" &&
  git config --global core.editor "code --wait"
```

## 3. Langs

### 3.1. Cpp

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/langs/cpp.sh")"
```

### 3.2. Golang

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/langs/golang.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

### 3.3. Rust

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/langs/rust.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |

### 3.4. Python

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/langs/python.sh")"
```

| Environment Variables |
| :-: |
| `ENABLE_CHINA_MIRROR=1` |
