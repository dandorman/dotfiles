shopt -s globstar autocd checkwinsize histappend

export CLICOLOR=1
export EDITOR=vim
export TERM_ITALICS=true

alias ssh="TERM=xterm-256color ssh"

################################################################################
# History

# http://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history#answer-18443
export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=10000
export HISTIGNORE="bg:fg:history:jobs:ls:git status:git st:git s:git diff:git d"
export HISTSIZE=10000
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMT_COMMAND"

################################################################################
# Git

if [ -f $HOME/.git-completion.bash ]; then
  source $HOME/.git-completion.bash
fi

if [ -f $HOME/.git-prompt.sh ]; then
  source $HOME/.git-prompt.sh
fi

################################################################################
# Prompt

COLOR_BOLD='\e[1m'
COLOR_RESET='\e[0m'
COLOR_RED_BOLD='\e[1;31m'
COLOR_YELLOW='\e[0;33m'

# $1: color code
# $2: text to wrap
function colorize {
  echo "\["$1"\]"$2"\[$COLOR_RESET\]"
}

# $1: text to wrap
function embolden {
  colorize $COLOR_BOLD $1
}

# "stock" PS1: \h:\W \u\$ (jem:connect ddorman$)
PS1="$(embolden "\w")$(colorize $COLOR_YELLOW '$(__git_ps1 " %s")') "

################################################################################
# Clojure

# More: http://swannodette.github.io/2014/12/22/waitin/
export LEIN_FAST_TRAMPOLINE=y
alias cljsbuild="lein trampoline cljsbuild $@"

################################################################################
# Ruby

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/gem_home/gem_home.sh

################################################################################
# Instructure

alias bridge="cd $HOME/Code/bridge && gem_home . && export PATH=./bin:\$PATH"
