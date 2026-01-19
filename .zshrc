# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# disable c-q, c-s to be caught by terminal
stty -ixon &> /dev/null

# Load the shell dotfiles
for file in ~/.{exports,private,aliases,functions,completion}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

ZSH_THEME="muse"
ZSH_DISABLE_COMPFIX="true"
setopt nonomatch
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(ssh-agent)

export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
export PATH="$HOME/.embulk/bin:$PATH"
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
export PATH="$HOME/.cargo/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# launch tmux
if [[ -z "$TMUX" ]] && command -v tmux &> /dev/null; then
    exec tmux
fi

## use coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
alias readlink="/usr/local/opt/coreutils/libexec/gnubin/readlink"

# peco setting
# requires ghq & peco
bindkey '^]' peco-src
function peco-src(){
  local src=$(ghq list --full-path|peco --query "$LBUFFER")
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N peco-src

# anyenv
eval "$(anyenv init -)"
