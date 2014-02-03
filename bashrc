shopt -s globstar autocd

export CLICOLOR=1
export EDITOR=vim

### chruby

source /usr/local/share/chruby/chruby.sh

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

### ruby

export RUBY_HEAP_MIN_SLOTS=12500000
export RUBY_HEAP_SLOTS_INCREMENT=2500000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=2500000
