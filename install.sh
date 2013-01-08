#!/bin/bash

DIR=$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)
FILES="bash_profile gemrc gitconfig githelpers gitignore tmux.conf zshrc"

for file in $FILES; do
  link=$HOME/.$file

  if [ -L $link -o ! -e $link ]; then
    if [ -L $link ]; then
      echo "unlinking .$file"
      unlink $link
    fi

    echo "linking .$file"
    ln -s "${DIR#$HOME/}/$file" "$HOME/.$file"

  else
    echo "skipping existing .$file"
  fi
done
