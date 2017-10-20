
# Path to your oh-my-zsh installation.

DEFAULT_PYTHON_VENV_VERSION=2
# DEFAULT_PYTHON_VENV_VERSION=3

#require install oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

#disable c-q, c-s to be caught by terminal
stty -ixon &> /dev/null
# run docker daemon
# default_dm_running="$(docker-machine ls|grep Running|grep default |awk '{print $1}')"
# if [ -z "$default_dm_running" ];then
  # docker-machine start default && eval "$(docker-machine env default)"
# else
  # eval "$(docker-machine env default)"
# fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
#for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
for file in ~/.{exports,private,aliases,functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="muse"


setopt nonomatch

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(ssh-agent tmux)

# User configuration

export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
#
# export PATH="$PATH:/usr/local/share/drill/bin"
export PATH="$HOME/.embulk/bin:$PATH"

# golang
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
# export PATH=$PATH:$HOME/anaconda3/bin

#rust
export PATH="$HOME/.cargo/bin:$PATH"

#nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/id_rsa"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#anaconda
# export PATH=/home/dicek/anaconda/bin:$PATH 
#

#python virtualenv
export PYTHON_VENV_HOME=$HOME/pyenv
#activate by default 
if [ $DEFAULT_PYTHON_VENV_VERSION -eq 2 ]; then
  . $PYTHON_VENV_HOME/venv27/bin/activate
elif [ $DEFAULT_PYTHON_VENV_VERSION -eq 3 ]; then
  . $PYTHON_VENV_HOME/venv35/bin/activate
fi
# source /usr/local/opt/autoenv/activate.sh

#show weather
# curl wttr.in/Tokyo


# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# apex auto completion
# _apex()  {
  # COMPREPLY=()
  # local cur="${COMP_WORDS[COMP_CWORD]}"
  # local opts="$(apex autocomplete -- ${COMP_WORDS[@]:1})"
  # COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  # return 0
# }

# complete -F _apex apex

#overwrite the slow function in oh-my-zsh
function git_prompt_status() {
# nop
}

# launch tmux
if [ "$TMUX" = "" ]; then tmux; fi

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
eval $(thefuck --alias)
