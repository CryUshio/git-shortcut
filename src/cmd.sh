#! /bin/bash

push() {
  branchName=$(git symbolic-ref --short -q HEAD 2>&1)
  echo "branch: $branchName"
  echo ""
  # 判断空字符串
  if test -z "$branchName"; then
    echo 'branchName is empty.'
  else
    git push origin $branchName
  fi
}

pull() {
  git pull origin $1
}

commit() {
  if test -z "$1"; then
    comment=$(echo $1 | grep '^-')
    echo $comment
    if test -z "$comment"; then
      git commit -m $comment
    else
      echo "git commit $*"
      git commit $*
    fi
  else
    git commit
  fi
}

submit() {
  echo "-> comment: \"$1\""
  echo ""
  if test -z "$1"; then 
    git add . && git commit -m "update." && push
  else
    git add . && git commit -m "$1" && push
  fi
}
