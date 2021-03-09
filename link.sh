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

if [ -d ".oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "powerlevel10k já clonado"
else
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git .oh-my-zsh/custom/themes/powerlevel10k
fi

link ".oh-my-zsh"
link ".xinitrc"
link ".Xresources"
link ".zshrc"
link_folder ".config"
