#! /bin/bash

push() {
  branchName=$(git symbolic-ref --short -q HEAD 2>&1)
  echo -e "-> branch: origin $branchName\n"
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
    git commit
  else
    comment=$(echo "$1" | grep '^-')
    if test -z "$comment"; then
      echo "-> git commit -m \"$1\""
      git commit -m "$1"
    else
      echo "-> git commit $*"
      git commit $*
    fi
  fi
}

submit() {
  if test -z "$1"; then
    git add . && commit "feat: update." && push
  else
    git add . && commit "$1" && push
  fi
}
