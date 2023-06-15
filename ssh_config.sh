#!/bin/bash

echo ''
echo 'PREPARE [Load GitHub SSH Key.] *********************************'
echo ''

FILE=$HOME/.ssh/github_id
DEST=$HOME/.dotfiles
if [ ! -f "$FILE" ]; then
    open https://github.com/login/
    exit
fi

eval "$(ssh-agent -s)"
echo ''
ssh-add $FILE
echo ''
ssh -T git@github.com

echo ''
echo 'RUN [Cloning .dotfiles Repository.] ***************************************'
echo ''

git clone git@github.com:N1ck3nd/.dotfiles.git $DEST