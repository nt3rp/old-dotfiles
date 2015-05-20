#!/bin/bash
# Symlink all files in this directory to the home directory

dir=`pwd`
files=`ls -a $dir`
script=`basename "$0"`

timestamp=`date +"%Y%m%d"`

for file in $files; do
    # TODO: Better way to check excluded files?
    if [ "$file" = "." ] || [ "$file" = ".." ] || [ "$file" = ".git" ] || [ "$file" = "$script" ]; then
        echo "Skipping $file"
        continue
    fi

    target="$HOME/$file"
    source="$dir/$file"

    if [ -e $target ]; then
        ext="${file##*.}"
        name="${file%.*}"

        cmd="mv $target $HOME/$name.$timestamp.$ext"
        echo $cmd
        `$cmd`
    fi

    cmd="ln -s $source $target"
    echo $cmd
    `$cmd`
done
