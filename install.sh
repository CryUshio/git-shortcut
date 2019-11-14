#! /bin/sh

exsist() {
  command -v $1 >/dev/null 2>&1
}

if ! exsist greadlink; then
  if test -n $(echo readlink -f | grep 'illegal'); then
    cat <<eof
Your system does not support \`readlink -f\`, please install coreutils:
    brew install coreutils

eof
    exit
  else
    cur_path="$(dirname $(readlink -f $0))"
  fi
else
  cur_path="$(dirname $(greadlink -f $0))"
fi

path=~/scripts/git-shortcut

. "$cur_path/src/utils.sh"

# debug
# rm -rf ~/scripts

# create dir and copy files
cd $cur_path
rm -rf $path
mkdir -p $path
cp -r $(ls | grep -v install.sh | xargs) $path
mv $path/main.sh $path/g
chmod +x $path/g
chmod +x $path/src/g-completion.bash

# set path
if ! exsist g; then
  cat <<eot >>~/.bash_profile

export GIT_SHORTCUT_HOME="$path"
export PATH=\$PATH:\$GIT_SHORTCUT_HOME
if [ -f "\$GIT_SHORTCUT_HOME/src/g-completion.bash" ]; then
  . \$GIT_SHORTCUT_HOME/src/g-completion.bash
fi

eot

  source ~/.bash_profile
fi

cat <<eof
Install success! Restart your Terminal to take effect.

GIT_SHORTCUT_HOME="$GIT_SHORTCUT_HOME"
Run \`g h\` to read helps.

eof

# apply configuration

# debug
# ls -l $path
