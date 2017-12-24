#!/bin/sh

# create symbolic links to the .files
# run for both user and root to have these files syncronized

function create_link {

  if [[ ! -f $2  ]]; then
    ln -s $1 $2
  else
    echo $1' already exists'
  fi

}

create_link $(pwd)/zshrc ~/.zshrc

create_link $(pwd)/vimrc ~/.vimrc

create_link $(pwd)/pystartup.py ~/.pystartup

