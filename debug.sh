#! /bin/bash

exsist() {
  command -v $1 >/dev/null 2>&1
}

envExsist() {
  grep 'g-completion' '/Users/sora/.bash_profile' >/dev/null 2>&1
}

if ! exsist g && ! envExsist; then
  echo 'not install'
else
  echo 'installed'
fi

if [ -f "/Users/sora/scripts/git-shortcut/g" ] && envExsist; then
  echo 'install success.'
fi
