util_exsist() {
  command -v $1 >/dev/null 2>&1
}

util_getBranchName() {
  result=$(git symbolic-ref --short -q HEAD 2>&1)

  if [[ "$result" == 'fatal'* ]]; then
    echo 
  else
    echo $result
  fi
}

util_replace() {
  originStr=$1
  matchVal=$2
  replaceVal=$3

  echo $originStr | sed "s/$matchVal/$replaceVal/g"
}
