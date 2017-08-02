#!/bin/bash

SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"

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

  # install neobundle 
  if [ ! -e "$HOME/.vim/bundle" ]; then 
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  fi


done

echo "Done."
