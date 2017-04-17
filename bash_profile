# system default: /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
# rearranged to make /usr/local/bin more prominent
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/X11/bin
PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
PATH=/usr/local/heroku/bin:$PATH
PATH=$(npm bin -g 2>/dev/null):$PATH
PATH=$HOME/bin:$PATH
export PATH=.git/safe/../../bin:$PATH

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

bashrc="$HOME/.bashrc"
if [ -f $bashrc ]; then
  source $bashrc
fi

test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash
