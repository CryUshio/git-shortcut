cmd_push() {
  branchName=$(util_getBranchName)
  # 判断空字符串
  if [ -z "$branchName" ]; then
    echo 'branchName is empty.'
  else
    echo -e "-> branch: origin $branchName\n"
    git push origin $branchName
  fi
}

cmd_pull() {
  branchName=$(util_getBranchName)
  # 判断空字符串
  if [ -z "$1" ]; then
    git pull origin $branchName
  else
    git pull origin $1
  fi
}

cmd_commit() {
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

cmd_submit() {
  if [ -z "$1" ]; then
    git add . && (cmd_commit "feat: update.") && cmd_push
  else
    _1="$1"
    shift
    git add . && (cmd_commit "$_1" $*) && cmd_push
  fi
}

cmd_merge() {
  targetBranch="$1"
  recBranch=$(util_getBranchName)

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
      echo "$(doMerge)"
    else
      echo 'Your branch now is in `master`, add `-f` at the end to enforce.'
    fi
  else
    echo "$(doMerge)"
  fi
}

cmd_newBranch() {
  recBranch=$(util_getBranchName)
  branchName="$1"
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

cmd_remove() {
  branchName=$([ "$2" == '-'* ] && echo "$1" || echo "$1 $2")
  cmd="${!#}"

  if [ "$cmd" == "-r" ]; then
    git push origin :$branchName
  elif [ "$cmd" == "-D" ]; then
    git branch -D $branchName
  else
    git branch -d $branchName
  fi
}
