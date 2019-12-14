#! /bin/bash

getPath() {
  echo './test.sh'
}

  echo "
export PATH=\$PATH:$path
if [ -f "$path/g-completion.bash" ]; then
  . $path/g-completion.bash
fi" >> `getPath`
