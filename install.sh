#! /bin/sh
cur_path=$(dirname $(greadlink -f $0))
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

# set path
if ! exsist g; then
  cat <<eot >>~/.bash_profile

export GIT_SHORTCUT_HOME="$path"
export PATH=\$PATH:\$GIT_SHORTCUT_HOME

eot

  source ~/.bash_profile
fi

# apply configuration

# debug
# ls -l $path
