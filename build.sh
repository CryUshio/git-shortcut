#! /bin/bash

rm -rf ./release
mkdir ./release
cp ./src/g-completion.bash ./release
touch ./release/g

cat << EOF >> ./release/g
#! /bin/bash

# version
version=$(git describe --tags `git rev-list --tags --max-count=1`)


# utils
`cat ./src/utils.sh`


# commands
`cat ./src/cmd.sh`


# main
`cat ./src/index.sh`
EOF
