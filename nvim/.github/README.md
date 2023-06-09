<div align="center">
  <h1> MY NEOVIM CONFIG </h1>
</div>

![Screenshot1](https://raw.githubusercontent.com/bocha13/myDotFiles/master/nvim/.github/screen.png)

## Requirements

- Neovim >= 0.9
- git >= 2.31.0
- [Nodejs](https://nodejs.org/en/)
- [Rust](https://rustup.rs/) (optional)
- ripgrep (optional)

## Installation

[Skip to Mac specifics config](#MacOS)

### Linux / wsl

#### Install neovim from source

- clone nvim from https://github.com/neovim/neovim.git
- checkout the branch with the version you want to install (eg. release-0.9)
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

- search and download the font you want from here [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
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
