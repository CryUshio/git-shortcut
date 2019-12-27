cmd_push() {
  local branchName=$(util_getBranchName)
  local cmd="$1"
  # 判断空字符串
  if [ -z "$branchName" ]; then
    echo '> push: branchName is empty.'
  elif [ -z "$cmd" ]; then
    echo -e "> push: origin $branchName\n"
    git push origin $branchName
  else
    echo -e "> push $cmd: origin $branchName\n"
    git push origin $branchName $cmd
  fi
}

cmd_pull() {
  local branchName=$(util_getBranchName)
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
      echo "> commit: git commit $*"
      git commit $*
    else
      comment="$1"
      shift
      echo "> commit: git commit -m \"$comment\" $*"
      git commit -m "$comment" $*
    fi
  fi
}

cmd_submit() {
  if [ -z "$1" ]; then
    git add . && (cmd_commit "feat: update") && cmd_push
  else
    local _1="$1"
    shift
    git add . && (cmd_commit "$_1" $*) && cmd_push
  fi
}

cmd_merge() {
  local targetBranch=$([ -z "$1" ] && echo 'master' || echo "$1")
  local recBranch=$(util_getBranchName)
  echo "> merge: $targetBranch -> $recBranch"

  doMerge() {
    if [ "$targetBranch" == "master" ]; then
      git checkout master && git pull && git checkout - && git merge master
    else
      git merge "$targetBranch"
    fi
  }

  if [ "$recBranch" == "$targetBranch" ]; then
    echo "Can not merge itself."
    return
  fi

  if [ "$recBranch" == "master" ]; then
    local cmd="$2"
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
  local recBranch=$(util_getBranchName)
  local branchName="$1"
  local cmd="$2"

  if [ "$recBranch" != "master" ]; then
    if [ "$cmd" == "-f" ]; then
      git checkout -b "$branchName"
    else
      echo '> checkout -b: Your branch now is not in `master`, add `-f` at the end to enforce.'
    fi
  else
    git checkout -b "$branchName"
  fi
}

cmd_remove() {
  local branchName=$([[ "$2" == '-'* ]] && echo "$1" || echo "$1 $2")
  local cmd="${!#}"

  if [ "$cmd" == "-r" ]; then
    git push origin :$branchName
  elif [ "$cmd" == "-D" ]; then
    git branch -D $branchName
  else
    git branch -d $branchName
  fi
}

cmd_rename() {
  local recBranch=$(util_getBranchName)
  local remote=$(git branch -a 2>&1 | grep "remotes/origin/$recBranch")
  if [ -z "$remote" ]; then
    # local
    git branch -m "$recBranch" "$1"
  else
    # remote
    git branch -m "$recBranch" "$1"
    git push origin :"$recBranch"
    git push origin "$1"
  fi
}

cmd_tag() {
  local tagName=$1
  local comment=""
  local cmd=""

  if [ -z "$tagName" ]; then
    # show tag list
    git tag
    return
  fi

  if [ -z "$(util_isCmd $2)" ]; then
    # comment
    comment="$2"
    cmd=$3
  else
    cmd=$2
  fi

  case $cmd in
  "")
    # no cmd
    echo -e "> git tag -a $tagName -m \"$comment\"\n"
    git tag -a $tagName -m "$comment"
    ;;
  "-p")
    # tag push
    echo -e "> git push origin $tagName\n"
    git push origin $tagName
    ;;
  "-s")
    # create and push
    echo -e "> git tag -a $tagName -m \"$comment\"\ngit push origin $tagName\n"
    git tag -a $tagName -m "$comment" && git push origin $tagName
    ;;
  "-d")
    # delete local tag
    echo -e "> git tag -d $tagName\n"
    git tag -d $tagName
    ;;
  "-dr")
    # delete remote tag
    echo -e "> git push origin :$tagName\n"
    git push origin :$tagName
    ;;
  *)
    echo "> g tg: $cmd: no cmd match."
    ;;
  esac
}
