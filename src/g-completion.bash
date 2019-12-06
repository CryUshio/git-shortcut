#! /bin/bash

getBranchs() {
  result=$(git branch -a 2>&1 | sed "s/^[* ] //g" | sed "s/remotes\/origin\///g" | sed "/HEAD/d")

  if [[ "$result" == *'fatal'* ]]; then
    echo ''
  else
    echo "$(printf '%s\n' "${result[@]}" | sort | uniq)"
  fi
}

getWordList() {
  cur=$1
  branchs=$(getBranchs)
  wordList=`getBranchs | grep "$cur"`
  words=`getBranchs | grep "^$cur"`

  if [ -z "$words" ]; then
    echo "$wordList"
  else
    echo "$words"
  fi  
}

g_complete() {
  COMPREPLY=()
  words=()
  local cur=${COMP_WORDS[COMP_CWORD]}
  local cmd=${COMP_WORDS[COMP_CWORD - 1]}
  wordList=$(getWordList $cur)
  dateTime=$(date +%Y%m%d)

  case $cur in
  cm | sm | + | br | mg | ck | rm | rn)
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
    # words=($(compgen -W "$branchs" -- $cur))
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
    for i in "${!words[@]}"; do
      COMPREPLY[$i]="$(printf '%*s' "-$COLUMNS" "${words[$i]}")"
    done
  fi

  return 0
}

complete -F g_complete g
