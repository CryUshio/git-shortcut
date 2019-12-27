util_exsist() {
  command -v $1 >/dev/null 2>&1
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
