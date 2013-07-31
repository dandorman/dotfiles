#!/bin/sh

path="$HOME/.ah-scripts"
if [[ -d $path ]]; then
  export AH_PATH=$path
  export AH_SCRIPT_PATH="$AH_PATH/scripts"

  source "$AH_SCRIPT_PATH/all.sh"
fi
