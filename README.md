# 🏠 myDotFiles

> *A curated collection of personal configuration files for a productive development environment*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Neovim](https://img.shields.io/badge/Neovim-0.11+-green.svg)](https://neovim.io/)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)

This repository contains my personal dotfiles and configuration setups for various tools and window managers. Each configuration is designed to work with my system so it might not work out of the box for you!.

## 🚀 Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/myDotFiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Choose your setup**
   - Most configurations should be placed in `~/.config/`
   - Follow the specific README in each folder for detailed instructions

## 📦 What's Included

### 🖥️ **Window Managers & Desktop Environment**

#### **Hyprland** (Wayland Compositor)
Modern tiling compositor with beautiful animations and extensive customization options.
- **Hyprland**: Main compositor configuration with optimized performance settings
- **Waybar**: Customizable status bar with system information and workspace indicators  
- **Hyprlock**: Secure screen locker with aesthetic blur effects
- **Hypridle**: Intelligent idle management for power saving
- **Hyprpaper**: Wallpaper manager with smooth transitions
- **Wofi**: Application launcher with fuzzy search capabilities
- **Wlogout**: Elegant logout menu with shutdown/restart options

#### **i3wm** (X11 Window Manager)
Lightweight tiling window manager perfect for productivity and resource efficiency.
- **i3**: Highly configurable tiling window manager
- **i3status**: Minimal status bar showing system information
- **Dunst**: Notification daemon with customizable appearance
- **Lock script**: Secure screen locking functionality

### 🖥️ **Terminal & Multiplexer**

#### **Terminal Emulators**
- **Alacritty**: GPU-accelerated terminal with excellent performance
- **Ghostty**: Modern terminal emulator with native performance
- **WezTerm**: Feature-rich terminal with Lua configuration

#### **Tmux**
Terminal multiplexer for managing multiple terminal sessions with:
- Custom key bindings and theme
- Plugin management via TPM (Tmux Plugin Manager)
- Session persistence and restoration

### ⚡ **Development Tools**

#### **Neovim** 
Modern Vim-based editor powered by [💤 lazy.nvim](https://github.com/folke/lazy.nvim) with:
- **LSP Support**: Native Language Server Protocol integration for multiple languages
- **Autocompletion**: [blink.cmp](https://github.com/saghen/blink.cmp) for intelligent code completion
- **Fuzzy Finding**: [Telescope](https://github.com/nvim-telescope/telescope.nvim) for file and content search
- **Syntax Highlighting**: [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for accurate parsing
- **Git Integration**: [Fugitive](https://github.com/tpope/vim-fugitive) for version control workflow
- **File Explorer**: [Oil.nvim](https://github.com/stevearc/oil.nvim) for intuitive file management
- **Status Line**: [Lualine](https://github.com/nvim-lualine/lualine.nvim) for informative status display
- **Theme**: [Catppuccin](https://github.com/catppuccin/nvim) colorscheme for visual consistency

**Supported Languages:**
- Astro, C/C++, CSS, Go, HTML, JSON, Lua, Rust, TypeScript/JavaScript

#### **Zsh**
Enhanced shell configuration for improved productivity and user experience.

### 🎨 **Aesthetics**
- **Wallpapers**: Curated collection of high-quality wallpapers
- **Consistent Theming**: Unified color schemes across all applications
- **Nerd Fonts**: Beautiful icons and symbols throughout the interface

## 🛠️ Installation Requirements

### **System Requirements**
- Linux distribution (tested on Ubuntu/Arch)
- Git >= 2.43.0
- For Neovim: version >= 0.11 with LuaJIT support

### **Optional Dependencies**
- [Nerd Font](https://www.nerdfonts.com/) for icon support
- Clipboard utility (e.g., `xclip` for X11, `wl-clipboard` for Wayland)

## 📂 Repository Structure

```
myDotFiles/
├── alacritty/          # Alacritty terminal configuration
├── ghostty/            # Ghostty terminal configuration  
├── hyprland/           # Complete Hyprland ecosystem setup
│   ├── hypr/           # Hyprland compositor settings
│   ├── waybar/         # Status bar configuration
│   ├── wlogout/        # Logout menu setup
│   └── wofi/           # Application launcher
├── i3wm/               # i3 window manager configuration
│   ├── i3/             # i3 window manager settings
│   ├── i3status/       # Status bar configuration
│   └── dunst/          # Notification daemon
├── nvim/               # Neovim editor configuration
├── tmux/               # Terminal multiplexer setup
├── wezterm/            # WezTerm terminal configuration
├── zsh/                # Zsh shell configuration
└── wallpapers/         # Collection of wallpapers
```

## 💡 Usage Tips

- **Configuration Placement**: Most configs belong in `~/.config/` directory
- **Modular Design**: Each tool can be used independently or as part of the complete setup
- **Documentation**: Check individual README files in each folder for specific setup instructions
- **Customization**: All configurations are designed to be easily modified to suit personal preferences

## 📄 License

This project is licensed under the MIT License - see individual configuration files for any specific licensing requirements.
