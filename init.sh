#!/bin/bash

SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install packages from Brewfile
echo "Installing packages from Brewfile"
brew bundle --file="$SCRIPT_DIR/Brewfile"

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

if [ ! -e "$HOME/.cache/dein" ]; then
  echo "Installing dein.vim"
  mkdir -p ~/.cache/dein
  git clone https://github.com/Shougo/dein.vim ~/.cache/dein/repos/github.com/Shougo/dein.vim
fi

for tgt in backups swaps undo
do
  mkdir -p ~/.vim/${tgt}
done

echo "Creating soft links for dotfiles"

for f in `ls -a|grep '^\.[a-zA-Z][a-zA-Z]*'`
do 
  [[ "$f" == .git* ]] && continue
  [[ "$f" == ".DS_Config" ]] && continue
  if [ ! -e "$HOME/$f" ]; then 
    echo "creating $f" && ln -s "$SCRIPT_DIR/$f" "$HOME/$f"
    # echo "creating $f" 
  else
    echo "$HOME/$f already exists."
  fi


done

echo "Done."
