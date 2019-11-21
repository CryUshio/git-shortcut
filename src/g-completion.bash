#! /bin/bash

getBranchs() {
  result=$(git branch 2>&1 | sed "s/*//g")

  if [[ "$result" == *'fatal'* ]]; then
    echo ''
  else
    echo "$result"
  fi
}

g_complete() {
  COMPREPLY=()
  words=()
  local cur=${COMP_WORDS[COMP_CWORD]}
  local cmd=${COMP_WORDS[COMP_CWORD - 1]}
  branchs=$(getBranchs)

  case $cur in
  cm | sm | + | br | mg | ck | rm)
    words=("$cur")
    ;;
  esac
  case $cmd in
  # ad|ma|-|ps|pl|fh|cm|sm)
  # ;;
  +)
    if [[ "$cur" == *'%t'* ]]; then
      words=()
    else
      words=("$cur%t")
    fi
    ;;
  br | mg | ck | rm)
    words=($(compgen -W "$branchs" -- $cur))
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
