# Mac 环境搭建

- [1. Oh My Zsh](#1-oh-my-zsh)
- [2. Homebrew](#2-homebrew)
- [3. 安装软件](#3-安装软件)

## 1. Oh My Zsh

- 下载链接：<https://ohmyz.sh>
- 国内源：<https://mirrors.tuna.tsinghua.edu.cn/help/ohmyzsh.git/>
- 插件：
  - 自动补全：<https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh>
  - 高亮：<https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md/#Oh-my-zsh>
  - 主题：<https://github.com/romkatv/powerlevel10k#getting-started>

```bash
plugins=(z brew vscode zsh-autosuggestions zsh-syntax-highlighting)
```

## 2. Homebrew

- 下载链接：<https://brew.sh/zh-cn/>
- 国内源：
  - <https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/>
  - <https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/>

## 3. 安装软件

```bash
brew install --cask visual-studio-code orbstack
```

国内源：<https://dockerproxy.com>
