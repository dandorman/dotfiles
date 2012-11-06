shopt -s globstar autocd

. $HOME/dotfiles/shell/all.sh

### git

if [ -f $HOME/.git-completion.bash ]; then
  source $HOME/.git-completion.bash
fi

if [ -f $HOME/.git-prompt.sh ]; then
  source $HOME/.git-prompt.sh
fi

### prompt

COLOR_RESET='\e[0m'
COLOR_RED_BOLD='\e[1;31m'
COLOR_YELLOW='\e[0;33m'

# $1: color code
# $2: text to wrap
function color_wrap {
  echo "\["$1"\]"$2"\[$COLOR_RESET\]"
}

# "stock" PS1: \h:\W \u\$ (jem:connect ddorman$)
PS1="\w$(color_wrap $COLOR_YELLOW '$(__git_ps1 " (%s)")')‣ "

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
