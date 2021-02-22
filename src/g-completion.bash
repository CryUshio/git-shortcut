#!/bin/bash

getBranchs() {
  result=$(git branch -a 2>&1 | sed "s/^[* ] //g" | sed "s/remotes\/origin\///g" | sed "/HEAD/d")

  if [[ "$result" == *'fatal'* ]]; then
    echo ''
  else
    echo "$(printf '%s' "${result[@]}" | sort | uniq)"
  fi
}

getWordList() {
  cur=$1
  branchs=$(getBranchs)
  wordList=$(getBranchs | grep "$cur")
  words=$(getBranchs | grep "^$cur")

  if [ -z "$words" ]; then
    echo "$wordList"
  else
    echo "$words"
  fi
}

g_complete() {
  COMPREPLY=()
  words=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  cmd="${COMP_WORDS[COMP_CWORD - 1]}"
  wordList=$(getWordList $cur)
  dateTime=$(date +%Y%m%d)

  case $cmd in
  # ad|ma|-|ps|pl|fh|cm|sm)
  # ;;
  + | rn)
    if [[ "$cur" == *"$dateTime"* ]]; then
      words=()
    else
      words=("$cur$dateTime")
    fi
    ;;
  br | mg | ck | rm)
    words=($(compgen -W "$wordList"))
    ;;
  g)
    if [ -z "$cur" ]; then
      words=('help')
    else
      COMPREPLY=($(compgen -W "ad ma ps pl fh cm sm rn br mg ck rm help" -- $cur))
      return 0
    fi
    ;;
  esac


  # if [[ "$SHELL" == *"/bin/zsh"* ]]; then
  #   for (( i=0; i<${#words[@]}; i++ )) do
  #     COMPREPLY[$i]="${words[$i]}"
  #   done;
  #   return 0
  # fi

  if [[ "${#words[@]}" == "0" ]]; then
    COMPREPLY=()
  elif [[ "${#words[@]}" == "1" ]]; then
    COMPREPLY=("${words[@]##*/}")
  else
    i=0
    while [ $i -lt ${#words[@]} ]; do
      if [[ "$SHELL" == *"/bin/zsh" ]]; then
        COMPREPLY[$i]="${words[$i]}"
      else
        COMPREPLY[$i]="$(printf '%*s' "-$COLUMNS" "${words[$i]}")"
      fi
      let i++
    done
  fi

  return 0
}

complete -F g_complete g
