#!/bin/sh

echo "Creating soft links for dotfiles"

for f in .??*
do 
  [[ "$f" == .git* ]] && continue
  [[ "$f" == ".DS_Config" ]] && continue
  if [ ! -e "$HOME/$f" ]; then 
    echo "creating $f" && ln -s "$f" "$HOME/$f"
  else
    echo "$HOME/$f already exists."
  fi
done

echo "Done."
