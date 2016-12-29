shopt -s autocd checkwinsize cmdhist globstar histappend

export CLICOLOR=1
export EDITOR=vim
export TERM_ITALICS=true

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

################################################################################
# Aliases

alias ssh="TERM=xterm-256color ssh"

################################################################################
# History

# http://blog.sanctum.geek.nz/better-bash-history/
export HISTCONTROL=ignoreboth
export HISTFILESIZE=1000000
export HISTIGNORE="bg:fg:history:jobs:ls:git status:git st:git s:git diff:git d"
export HISTSIZE=1000000
export HISTTIMEFORMAT="%F %T "

################################################################################
# Git

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
# Rails

export DISABLE_SPRING=1

################################################################################
# Instructure

alias bridge="cd $HOME/Code/bridge && chruby \$(cat .ruby-version) && gem_home . && export PATH=\$(pwd)/bin:\$PATH"

export NVM_DIR="/Users/ddorman/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
