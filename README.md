# Setup Env

## Quick Start

Run the script directly to quickly install Zsh, Oh-My-Zsh and its plugins
 on Debian Bookworm.

```bash
./main.sh
```

## Instructions

This is a personalized script! It is recommended to refer to it and implement
 your own!

This script is for Debian Linux machines on Orbstack. It is intended for
 a minimal Debian installation.

It will eventually install Zsh, Oh-My-Zsh with some plugins.

When using this script, it is recommended to bypass the GFW to install
 various software from the official repository.

By running the script with ENABLE_CHINA_MIRROR, You can receive
 subsequent updates from Chinese mirror.

## Install

If you also want to create a global .gitconfig file, you can use the
 SET_GIT related variables.

```bash
SET_GIT_USER_NAME=${your_name} \
SET_GIT_USER_EMAIL=${your_email} \
./main.sh
```

If you want to use Chinese mirrors for subsequent installations, you can add
 the ENABLE_CHINA_MIRROR variable.

However, during the initial installation, it will still use the official
 sources.

this setting only takes effect for subsequent updates.

```bash
ENABLE_CHINA_MIRROR=1 \
SET_GIT_USER_NAME=${your_name} \
SET_GIT_USER_EMAIL=${your_email} \
./main.sh
```

## 参数

Respects the following environment variables:

|||
|:-:|:-|
|ENABLE_CHINA_MIRROR|enable Chinese mirror for subsequent updates.|
|SET_GIT_USER_NAME|set the user.name in global gitconfig.|
|SET_GIT_USER_EMAIL|set the user.email in global gitconfig.|
