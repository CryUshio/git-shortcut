#! /bin/bash

branch=remote=git branch -a 2>&1 | grep 'remote/origin'

echo $branch