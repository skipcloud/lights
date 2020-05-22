#!/bin/sh -

dir="$(realpath "$(dirname $0)"/..)"
compl=$dir/completion/zsh

if [ ! -e $compl/template ]; then
  echo "$compl/template is missing" >&2
  exit 1
fi

echo "$(realpath .)"
dir=$(echo $dir/.info/lights | sed 's/\//\\\//g')
cat $compl/template | sed "s/LIGHT_FILE/$dir/" > $compl/_lights

