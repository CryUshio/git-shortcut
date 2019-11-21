#! /bin/bash
. "$GIT_SHORTCUT_HOME/src/utils.sh"

push() {
  branchName=$(getBranchName)
  # 判断空字符串
  if [ -z "$branchName" ]; then
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
  if [ -z "$1" ]; then
    git commit
  else
    # only cmd start with '-'
    if [[ "$1" == '-'* ]]; then
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
  if [ -z "$1" ]; then
    git add . && (commit "feat: update.") && push
  else
    _1="$1"
    shift
    git add . && (commit "$_1" $*) && push
  fi
}

merge() {
  targetBranch="$1"
  recBranch=$(getBranchName)

  doMerge() {
    if [ -z "$targetBranch" ]; then
      git checkout master && git pull && git checkout - && git merge master
    else
      git merge "$targetBranch"
    fi
  }

  if [ "$recBranch" == "master" ]; then
    cmd="$2"
    if [ "$cmd" == "-f" ]; then
      doMerge
    else
      echo 'Your branch now is in `master`, add `-f` at the end to enforce.'
    fi
  else
    doMerge
  fi
}

newBranch() {
  recBranch=$(getBranchName)
  dateTime=$(date +%Y%m%d)
  branchName=$(replace "$1" "%t" "$dateTime")
  cmd="$2"

  if [ "$recBranch" != "master" ]; then
    if [ "$cmd" == "-f" ]; then
      git checkout -b "$branchName"
    else
      echo 'Your branch now is not in `master`, add `-f` at the end to enforce.'
    fi
  else
    git checkout -b "$branchName"
  fi
}
