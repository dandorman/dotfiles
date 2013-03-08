function bin_present() {
  if [[ $(which $1) = "" ]]; then
    if [[ $2 ]]; then
      echo no $2
    else
      echo no $1
    fi
    return 1
  fi
}

function bag() {
  bin_present bundle bundler  || return $?
  bin_present ag || return $?
  paths=$(bundle show --paths)
  if [[ $? = 10 ]]; then
    echo no Gemfile
    return 1
  else
    ag "$@" $paths
  fi
}
