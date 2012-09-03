# prompt

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " ("${ref#refs/heads/}")"
}

COLOR_RESET='\e[0m'
COLOR_RED_BOLD='\e[1;31m'
COLOR_YELLOW='\e[0;33m'

# $1: color code
# $2: text to wrap
function color_wrap {
  echo "\["$1"\]"$2"\[$COLOR_RESET\]"
}

# "stock" PS1: \h:\W \u\$ (jem:connect ddorman$)
PS1="\w$(color_wrap $COLOR_YELLOW '$(parse_git_branch)')‣ "

# git completion stuff

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

. $HOME/dotfiles/shell/all.sh

shopt -s globstar autocd
