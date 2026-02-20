# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

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

# Layout with neovim, claude and terminal
function nic() {
  local session_name="${1:-$(basename "$PWD")}"

  if [ -n "$TMUX" ]; then
    tmux kill-pane -a

    # Get the current pane ID (like %3)
    top_left=$(tmux display-message -p '#{pane_id}')

    # Split bottom (20%) from that pane
    bottom=$(tmux split-window -v -l 20% -P -F '#{pane_id}' -t "$top_left")

    # Split top horizontally (30%) from the SAME original pane
    top_right=$(tmux split-window -h -l 30% -P -F '#{pane_id}' -t "$top_left")

    tmux send-keys -t "$top_left" "nvim" C-m
    tmux send-keys -t "$top_right" "claude" C-m

    tmux select-pane -t "$top_left"

    return
  fi

  # ---- Outside tmux (unchanged) ----
  if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux attach-session -t "$session_name"
    return
  fi

  tmux new-session -d -s "$session_name" -c "$PWD"
  tmux split-window -v -t "$session_name" -l 20%
  tmux select-pane -t "$session_name":1.1
  tmux split-window -h -t "$session_name":1.1 -l 30%

  tmux send-keys -t "$session_name":1.1 "nvim" C-m
  tmux send-keys -t "$session_name":1.2 "claude" C-m

  tmux select-pane -t "$session_name":1.1
  tmux attach-session -t "$session_name"
}

# ---------------- ALIAS ----------------
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vim='nvim'
alias dosaml="yarn server do api --useHttps --host auth.learnlight.com --port 8443"

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

# NVM
set -h
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
set +h

# OPENCODE
export PATH=/home/bocha13/.opencode/bin:$PATH
export EDITOR="nvim"
