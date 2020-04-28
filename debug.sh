#!/bin/bash

getBranchs() {
  local result=$(git branch -a 2>&1 | sed "s/^[* ] //g" | sed "s/remotes\/origin\///g" | sed "/HEAD/d")

  if [[ "$result" == *'fatal'* ]]; then
    echo ''
  else
    echo "$(printf '%s' "${result[@]}" | sort | uniq)"
  fi
}

getWordList() {
  local cur=$1
  local branchs=$(getBranchs)
  local wordList=$(getBranchs | grep "$cur")
  local words=$(getBranchs | grep "^$cur")

  if [ -z "$words" ]; then
    echo "$wordList"
  else
    echo "$words"
  fi
}

g_complete() {
  COMPREPLY=()
  local words=()
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local cmd="${COMP_WORDS[COMP_CWORD - 1]}"
  local wordList=$(getWordList $cur)
  local dateTime=$(date +%Y%m%d)


  case $cur in
  cm | sm | + | br | mg | ck | rm | rn)
    # echo "cur=$cur" >> $HOME/g-complete.log
    words=("$cur")
    ;;
  esac
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
    fi
    ;;
  esac

  if [ "${#words[@]}" == "1" ]; then
    COMPREPLY=("${words[@]##*/}")
  else
    local i=0
    while [ $i -lt ${#words[@]} ]; do
      COMPREPLY[$i]="$(printf '%*s' "-$COLUMNS" "${words[$i]}")"
      let i++
    done
  fi

  return 0
}

complete -F g_complete g
