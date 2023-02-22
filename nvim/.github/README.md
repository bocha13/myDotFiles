<div align="center">
  <h1> NVIM </h1>
</div>

A customized neovim configuration
![Screenshot1](https://raw.githubusercontent.com/bocha13/myDotFiles/master/nvim/.github/screen.JPG)

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
