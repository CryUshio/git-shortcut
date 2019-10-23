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
  echo merge
}
