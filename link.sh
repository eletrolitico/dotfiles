#!/bin/bash

link()
{
  ln -sf dotfiles/$1 ../$1
}

link_folder()
{
  for f in $1/*; do
    ln -sf ../dotfiles/$f ../$f
  done
}

link ".oh-my-zsh"
link ".xinitrc"
link ".Xresources"
link ".zshrc"
link_folder ".config"
