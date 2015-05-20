#!/bin/bash
# Symlink all files in this directory to the home directory

dir=`pwd`
files=`ls -a $dir`
script=`basename "$0"`

timestamp=`date +"%Y%m%d"`

for file in $files; do
    # TODO: Better way to check excluded files?
    if [ "$file" = "." ] || [ "$file" = ".." ] || [ "$file" = ".git" ] || [ "$file" == ".oh-my-zsh" ] || [ "$file" = "$script" ]; then
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

# Modified from
# https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh#L33
install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $HOME/.oh-my-zsh/ ]]; then
        git clone http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
fi
}

install_zsh
