## This configuration only works in neovim 0.7

## Dependencies

Nodejs
- [Follow nodejs instructions](https://nodejs.org/en/)

Rust
- [Follow Rustup instructions](https://rustup.rs/)

Ripgrep
- ripgrep is a line-oriented search tool that recursively searches the current directory for a regex pattern.
```
sudo apt install ripgrep
```

Stylua
- An opinionated code formatter for Lua. StyLua is inspired by the likes of prettier.
```
cargo install stylua
```

[Skip to Mac specifics config](#MacOS)

# Linux / wsl

### Install neovim
- clone nvim from https://github.com/neovim/neovim.git
- checkout the branch with the version you want to install (eg. release-0.7)
- inside the repo run ``` make CMAKE_BUILD_TYPE=Release ```
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

### Install fonts
- clone https://github.com/ryanoasis/nerd-fonts
- install the font you want (be sure it has Nerd Font in the name to include icons)
- ```./install.sh <name of font>```
- set the font in your terminal preferences

# MacOS

### Neovim
```
brew install neovim
```
- To update neovim to lattest release
```
brew update neovim
```


### Fonts
- be sure that you are instaling a "nerd font" font 
```
brew tap homebrew/cask-fonts
brew install --cask <name-of-font>   ej: font-hack-nerd-font
```
