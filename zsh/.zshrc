# ---------- LOADS / IMPORTS ----------
autoload -Uz add-zsh-hook vcs_info
zstyle ':vcs_info:*' enable git svn


# ---------- FUNCTIONS ----------
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

# ----------- EXPORTS -------------
# homebrew export uncomment on macOS
export PATH="/opt/homebrew/bin:$PATH"

# vscode uncomment on windows
#export PATH=$PATH:"/mnt/c/Users/ignac/AppData/Local/Programs/Microsoft VS Code/bin"

# nvm export
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# enable CLI colours for Mac Terminal
export CLICOLOR=1

# ----------- PROMPT -----------
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

# ---------- ALIAS ----------
# readlink doesn't work like in linux so we map it
# to execute greadlink which works the same
alias readlink=greadlink
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vim='nvim'

# open tmux by default
#case $- in *i*)
#    [ -z "$TMUX" ] && exec tmux
#esac
