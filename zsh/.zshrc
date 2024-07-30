# ---------------- LOADS / IMPORTS ----------------
autoload -Uz add-zsh-hook vcs_info
# git completion
autoload -Uz compinit && compinit
zstyle ':vcs_info:*' enable git svn


# ---------------- FUNCTIONS ----------------
# File extraction
# usage: ex <file>
function ex(){
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)    tar xjf    $1  ;;
            *.tar.gz)     tar xzf    $1  ;;
            *.bz2)        bunzip2    $1  ;;
            *.rar)        unrar x    $1  ;;
            *.gz)         gunzip     $1  ;;
            *.tar)        tar xf     $1  ;;
            *.tbz2)       tar xjf    $1  ;;
            *.tgz)        tar xzf    $1  ;;
            *.zip)        unzip      $1  ;;
            *.Z)          uncompress $1  ;;
            *.7z)         7z x       $1  ;;
            *.deb)        ar x       $1  ;;
            *.tar.xz)     tar xf     $1  ;;
            *.tar.zst)    unzstd     $1  ;;
            *)            echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# ---------------- EXPORTS ----------------
# homebrew export
#export PATH="/opt/homebrew/bin:$PATH"

# code
# export PATH=$PATH:"/mnt/c/Users/ignac/AppData/Local/Programs/Microsoft VS Code/bin"

# DENO
# export DENO_INSTALL="/home/bocha13/.deno"
# export PATH="$DENO_INSTALL/bin:$PATH"

# go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/bin

# rust_analyzer
export PATH=$PATH:/.local/share/nvim/lsp_servers/rust/rust_analyzer

# nvm export
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

# export PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig/"

# ZIG
# export PATH=$PATH:/usr/bin/zig

# exercism cli
export PATH=$PATH:/usr/bin/exercism

# BUN
export BUN_INSTALL="/home/bocha13/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
# [ -s "/home/bocha13/.bun/_bun" ] && source "/home/bocha13/.bun/_bun"

# Android Studio
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/Applications/android-studio/bin

# PICO SDK
export PICO_SDK_PATH=$HOME/projects/pico/pico-sdk
alias get_idf='. $HOME/esp/esp-idf/export.sh'
export IDF_PATH=$HOME/esp/esp-idf

# EMACS
export PATH=$PATH:$HOME/.config/emacs/bin

# ---------------- PROMPT ----------------
# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# format vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '(%b%u%c)'

setopt prompt_subst
add-zsh-hook precmd vcs_info
PROMPT='[%n:%F{green}%.%f]%F{red}${vcs_info_msg_0_}%f$ '

# ---------------- ALIAS ----------------
# readlink doesn't work like in linux so we map it
# to execute greadlink which works the same
alias readlink=greadlink
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vim='nvim'
alias dosaml="yarn server do api --useHttps --host auth.learnlight.com --port 8443"

# Tmux
# # attaches tmux to a session
# alias ta='tmux attach -t'
# # creates a new session
# alias tn='tmux new-session -s '
# # kill session
# alias tk='tmux kill-session -t '
# # list all ongoing sessions
# alias tl='tmux list-sessions'
# # detach from session
# alias td='tmux detach'
# # tmux clear pane
# alias tc='clear; tmux clear-history; clear'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Start Tmux if not already running
if [[ -z "$TMUX" ]]; then
    # Check for detached sessions
    if [[ $(tmux list-sessions 2>/dev/null) ]]; then
        # Open the first detached session
        tmux attach-session -t $(tmux list-sessions -F "#S" 2>/dev/null | head -n 1)
    else
        # No detached sessions, start a new Tmux session
        tmux new-session
    fi
fi
# PATH="$HOME/.local/bin:$PATH"

# ---------------- PLUGINS ----------------
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
