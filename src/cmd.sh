#! /bin/bash
. "$GIT_SHORTCUT_HOME/src/utils.sh"

push() {
  branchName=$(getBranchName)
  # 判断空字符串
  if test -z "$branchName"; then
    echo 'branchName is empty.'
  else
    echo -e "-> branch: origin $branchName\n"
    git push origin $branchName
  fi
}

pull() {
  git pull origin $1
}

commit() {
  if test -z "$1"; then
    git commit
  else
    # only cmd start with '-'
    isCmd=$(echo "$1" | grep '^-')
    if test -n "$isCmd"; then
      echo "-> git commit $*"
      git commit $*
    else
      comment="$1"
      shift
      echo "-> git commit -m \"$comment\" $*"
      git commit -m "$comment" $*
    fi
  fi
}

submit() {
  if test -z "$1"; then
    git add . && (commit "feat: update.") && push
  else
    _1="$1"
    shift
    git add . && (commit "$_1" $*) && push
  fi
}

merge() {
  if test -z "$1"; then
    git checkout master && git pull && git checkout - && git merge master
  else
    git merge "$1"
  fi
}

newBranch() {
  recBranch=$(getBranchName)
  dateTime=$(date +%Y%m%d)
  branchName=$(replace "$1" "%t" "$dateTime")
  cmd="$2"

  if [ "$recBranch" != "master" ]
  then
    if [ "$cmd" == "-f" ]
    then
      git checkout -b "$branchName"
    else
      echo 'Your branch now is not in `master`, if you want to create a branch, please add `-f` at the end.'
    fi
  else
    git checkout -b "$branchName"
  fi
}
