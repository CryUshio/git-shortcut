#! /bin/bash
. ./src/utils.sh

path=~/scripts/git-shortcut

# debug
# rm -rf ~/scripts

# create dir and copy files
mkdir -p $path
cp -r `ls | grep -v install.sh | xargs` $path
mv $path/main.sh $path/g
chmod +x $path/g

# set path
if ! exsist g; then
cat << eot >> ~/.bash_profile

export PATH=\$PATH:~/scripts/git-shortcut

eot
fi
# apply configuration
source ~/.bash_profile

# debug
ls -l $path