shopt -s autocd checkwinsize cmdhist globstar histappend

export CLICOLOR=1
export EDITOR=vim
export TERM_ITALICS=true

[ -f "$(brew --prefix)/etc/bash_completion" ] \
  && source "$(brew --prefix)/etc/bash_completion"

################################################################################
# Aliases

alias bx="bundle exec"
alias venv=". .venv/bin/activate"

################################################################################
# History

# http://blog.sanctum.geek.nz/better-bash-history/
export HISTCONTROL=ignoreboth
export HISTFILESIZE=1000000
export HISTIGNORE="bg:fg:history:jobs:ls:git status:git st:git s:git diff:git d"
export HISTSIZE=1000000
export HISTTIMEFORMAT="%F %T "

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
# CUDA

export CUDA_HOME=/usr/local/cuda
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"
export PATH="$CUDA_HOME/bin:$PATH"

################################################################################
# Ruby

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/gem_home/gem_home.sh

################################################################################
# Rails

export DISABLE_SPRING=1

################################################################################
# JavaScript

if [ -a "$(brew --prefix nvm)/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  . "$(brew --prefix nvm)/nvm.sh"
fi

################################################################################
# Instructure

alias bridge="cd $HOME/Code/bridge && chruby \$(cat .ruby-version) && gem_home . && nvm use > /dev/null && export PATH=\$(pwd)/bin:\$PATH"

export VAULT_ADDR=https://vault.insops.net

# Sometimes Vaulted's session-token stuff just doesn't work. This strips its
# environment down to AWS_ACCESS_KEY and AWS_SECRET_ACCESS_KEY, with those
# values set to the explicit values stored in Vaulted.
function raw_vaulted {
  if [[ -z $VAULTED_ENV ]]; then
    echo 'No $VAULTED_ENV set'
    return 1
  fi

  for var in AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_SECURITY_TOKEN; do
    unset $var
  done

  local vaulted_dump=$(vaulted dump $VAULTED_ENV)
  export AWS_ACCESS_KEY_ID=$(echo $vaulted_dump | jq -r .aws_key.id)
  export AWS_SECRET_ACCESS_KEY=$(echo $vaulted_dump | jq -r .aws_key.secret)
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
