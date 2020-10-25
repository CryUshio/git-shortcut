util_env() {
  echo $SHELL
}

util_isGitRepo() {
  git rev-parse --git-dir >/dev/null 2>&1
}

util_exsist() {
  command -v $1 >/dev/null 2>&1
}

util_matchReg() {
  local text="$1"
  local reg="$2"

  echo $(echo "$text" | egrep "$reg")
}

util_getBranchName() {
  local result=$(git symbolic-ref --short -q HEAD 2>&1)

  if [[ "$result" == 'fatal'* ]]; then
    echo
  else
    echo $result
  fi
}

util_replace() {
  local originStr=$1
  local matchVal=$2
  local replaceVal=$3

  echo $originStr | sed "s/$matchVal/$replaceVal/g"
}

util_isCmd() {
  if [[ "$1" == "-"* ]]; then
    echo "$1"
  fi
}

util_isCommitId() {
  if [ -n "$1" ]; then
    echo $(util_matchReg "$1" "^[0-9a-f]+$")
  fi
}
