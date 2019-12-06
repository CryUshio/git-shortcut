#! /bin/bash

getBranchs() {
  result=$(git branch -a 2>&1 | sed "s/^[* ] //g" | sed "s/remotes\/origin\///g" | sed "/HEAD/d")

  if [[ "$result" == *'fatal'* ]]; then
    echo ''
  else
    echo "$(printf '%s\n' "${result[@]}" | sort | uniq)"
  fi
}

cur=$1
branchs=("$(getBranchs)")
wordList=$(getBranchs | grep "$cur")
words=$(getBranchs | grep "^$cur")
echo "$branchs"
if [ -z "$words" ]; then
  echo "wordList: $wordList"
else
  echo "words: $words"
fi

