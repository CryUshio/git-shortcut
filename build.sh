#! /bin/bash

rm -rf ./release
mkdir ./release
cp ./src/g-completion.bash ./release
touch ./release/g

cat << EOF >> ./release/g
#! /bin/bash


# utils
`cat ./src/utils.sh`


# commands
`cat ./src/cmd.sh`


# main
`cat ./src/index.sh`
EOF
