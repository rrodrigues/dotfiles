#!/bin/sh

# create symbolic links to the .files
# run for both user and root to have these files syncronized

ln -s $(pwd)/zshrc ~/.zshrc

ln -s $(pwd)/vimrc ~/.vimrc
