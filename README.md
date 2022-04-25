# Astzweig Dotfiles
This repository contains dotfiles for a standarized configuration of different
applications on Unix systems of Astzweig systems.

## Install
Clone onto your computer:

```zsh
git clone https://github.com/astzweig/dotfiles.git ~/dotfiles
```

Install the dotfiles

```zsh
RCRC=$HOME/dotfiles/rcrc rcup
```
## What's included?

| filename | description | rcm tags |
| -------- | ----------- | -------- |
| aliases  | Contains aliases for the shell. | - |
| curlrc   | Configures curl with right user-agent and other useful stuff. | - |
| editorconfig | Configures editors with sane defaults regarding indention and trailing whitespace. | - |
| config/git/ignore | Configures global gitignore patterns. | - |
| hushlogin | Silence last login notice in shell. | - |
| vimrc | Configure vim with useful features like numbers and shortcuts. | vim |
| zshrc | Configures zsh to include aliases and further functions. | zsh |

### Pre-Up Hooks

| filename | description |
| -------- | ----------- |
| configureMacOS | Set the preferences of macOS system behaviour and certain apps. |
| writeHostname | Write the current macOS hostname to the rcrc config file. |
| installHomebrew | Install Homebrew for the current user |
