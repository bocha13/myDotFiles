

## Dependencies

Ripgrep

```
sudo apt install ripgrep
```

## Install neovim
- clone nvim from https://github.com/neovim/neovim.git
- checkout the branch with the version you want to install (ej. release-0.7)
- inside the repo run ``` make CMAKE_BUILD_TYPE=Release ```
- then run "sudo make install"
- if no errors, nvim should be installed

## Install fonts
- clone https://github.com/ryanoasis/nerd-fonts
- install the font you want (be sure it has Nerd Font in the name to include icons)
- ```./install.sh <name of font>```
- set the font in your terminal preferences

### FONTS IN MAC
```
brew tap homebrew/cask-fonts
brew install --cask <name-of-font>   ej: font-hack-nerd-font
```

#### Upgrade to latest release
Inside the cloned neovim repo run the following commands
```
git pull
make distclean && make CMAKE_BUILD_TYPE=Release
sudo make install
nvim -v
```
