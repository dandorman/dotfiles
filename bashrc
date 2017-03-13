shopt -s autocd checkwinsize cmdhist globstar histappend

export CLICOLOR=1
export EDITOR=vim
export TERM_ITALICS=true

for f in $(brew --prefix)/etc/bash_completion.d/*; do
  source $f
done

################################################################################
# Aliases

alias bx="bundle exec"

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
alias insops="eval \$(vaulted env insops)"
alias inseng="eval \$(vaulted env inseng)"
alias inscg="eval \$(vaulted env cg)"

bcq() { ssh jump.prod.us-east-1.insops.net "psql -U \$( whoami )-ro -h bouncer.bridge-prod.insops.net cluster1 -qAtXF\\| -c \"select elapsed_time, xact_time, usename, state, substr(replace(query,'\\n',' '),0,100) from dba.current_queries order by elapsed_time desc\"" |column -s\| -t; }

export VAULT_ADDR=https://vault.insops.net
