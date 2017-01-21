#!/bin/sh

SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"

echo "Creating soft links for dotfiles"

for f in `ls -a|grep '^\.[a-zA-Z][a-zA-Z]*'`
do 
  [[ "$f" == .git* ]] && continue
  [[ "$f" == ".DS_Config" ]] && continue
  if [ ! -e "$HOME/$f" ]; then 
    echo "creating $f" && ln -s "$f" "$HOME/$f"
    # echo "creating $f" 
  else
    echo "$HOME/$f already exists."
  fi
done

echo "Done."
