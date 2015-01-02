shopt -s globstar autocd checkwinsize

export CLICOLOR=1
export EDITOR=vim

### chruby

source /usr/local/share/chruby/chruby.sh

### docker

if [[ -x $(which docker) ]]; then
  export DOCKER_HOST=tcp://192.168.59.103:2376
  export DOCKER_CERT_PATH=/Users/dan/.boot2docker/certs/boot2docker-vm
  export DOCKER_TLS_VERIFY=1
fi

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
PS1="\w$(color_wrap $COLOR_YELLOW '$(__git_ps1 " %s")') "

# clojure

# More: http://swannodette.github.io/2014/12/22/waitin/
export LEIN_FAST_TRAMPOLINE=y
alias cljsbuild="lein trampoline cljsbuild $@"
