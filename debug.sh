#! /bin/bash

branch=$([ -z "$1" ] && echo 'master' || echo "$1")

echo $branch