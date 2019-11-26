#! /bin/bash

result=($(git branch -a 2>&1 | sed "s/^[* ]//g" | sed "s/remotes\/origin\///g" | sed "/HEAD/d"))

echo $(printf '%s\n' "${result[@]}" | sort | uniq)