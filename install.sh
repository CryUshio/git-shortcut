#! /bin/sh

exsist() {
  command -v $1 >/dev/null 2>&1
}

envExsist() {
  grep 'g-completion' '/Users/sora/.bash_profile' >/dev/null 2>&1
}

writeEnv() {
  cat <<eot >>~/.bash_profile

export PATH=\$PATH:$path
if [ -f "$path/g-completion.bash" ]; then
  . $path/g-completion.bash
fi

eot
}

path=~/scripts/git-shortcut

# debug
# rm -rf ~/scripts

# release
sh ./build.sh

# create dir and copy files
rm -rf $path
mkdir -p $path
cp -r ./release/* $path
chmod +x $path/g
chmod +x $path/g-completion.bash

# set path
if ! exsist g; then
  if ! envExsist; then
    writeEnv
  fi

  source ~/.bash_profile
fi


if [ -f "$path/g" ] && envExsist; then
  cat <<eof
Install success! Restart your Terminal to take effect.

Run \`g h\` to read helps.

eof
else
  echo 'Some errors occurred. Please try agnin.'
fi

# apply configuration

# debug
# ls -l $path
