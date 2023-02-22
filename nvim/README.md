<div align="center">
  <h1> NVIM </h1>
</div>
<div align="center">
![GitHub top language](https://img.shields.io/github/languages/top/bocha13/myDotFiles?color=6d92bf&style=for-the-badge)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/bocha13/myDotFiles?color=e1b56a&style=for-the-badge)
![GitHub Repo stars](https://img.shields.io/github/stars/bocha13/myDotFiles?color=74be88&style=for-the-badge)
</div>

![Screenshot1](https://raw.githubusercontent.com/bocha13/myDotFiles/nvim/screen.jpg)

A customized neovim configuration

## Requirements

- Neovim >= 0.8
- git >= 2.31.0
- [Nodejs](https://nodejs.org/en/)
- [Rust](https://rustup.rs/) (optional)
- ripgrep (optional)

## Installation

[Skip to Mac specifics config](#MacOS)

### Linux / wsl

#### Install neovim from source

- clone nvim from https://github.com/neovim/neovim.git
- checkout the branch with the version you want to install (eg. release-0.7)
- inside the repo run `make CMAKE_BUILD_TYPE=Release`
- then run "sudo make install"
- if no errors, nvim should be installed

#### Upgrade to latest release

Inside the cloned neovim repo run the following commands

```
git pull
make distclean && make CMAKE_BUILD_TYPE=Release
sudo make install
nvim -v
```

#### Install fonts

- clone https://github.com/ryanoasis/nerd-fonts
- install the font you want (be sure it has Nerd Font in the name to include icons)
- `./install.sh <name of font>`
- set the font in your terminal preferences

### MacOS

#### Neovim

```
brew install neovim
```

- To update neovim to lattest release

```
brew update neovim
```

#### Fonts

- be sure that you are instaling a "nerd font" font

```
brew tap homebrew/cask-fonts
brew install --cask <name-of-font>   ej: font-hack-nerd-font
```
