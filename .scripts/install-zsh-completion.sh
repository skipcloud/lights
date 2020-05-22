#!/bin/sh -

dir=$(realpath $(dirname $0)/..)/completion/zsh

if [ -e $dir/_lights ]; then
  ln -sf $dir/_lights /usr/local/share/zsh/site-functions
else
  echo "
  error: zsh completion file is missing
  run make install/completion
  " >&2
fi
