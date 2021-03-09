#!/bin/bash

link()
{
  echo "ln -sfT ../dotfiles/$1 ../$1"
  ln -sfT dotfiles/$1 ../$1
}

link_folder()
{
  for f in $1/*; do
    echo "linking $f"
    ln -sfT ../dotfiles/$f ../$f
  done
}

if  [ $# -ne 1 ] || [[ $1 != "link" && $1 != "install" && $1 != "all" ]] ; then
  echo "Options:"
  echo "  link - symlinks config files"
  echo "  install - installs packages (including yay)"
  echo "  all - symlinks configs and install packages"

  exit 1
fi

if [ $1 == "link" ] || [ $1 == "all" ]; then
  if [ ! -f ".oh-my-zsh/oh-my-zsh.sh" ]; then
    rm -rf .oh-my-zsh
    git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh
  fi
  if [ -d ".oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "powerlevel10k já clonado"
  else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git .oh-my-zsh/custom/themes/powerlevel10k
  fi

  link ".oh-my-zsh"
  link ".xinitrc"
  link ".Xresources"
  link ".xscreensaver"
  link ".zshrc"
  link ".p10k.zsh"
  link_folder ".config"
  link_folder ".local"
fi

if [ $1 == "install" ] || [ $1 == "all" ]; then
  sudo pacman -Syyuu --noconfirm
  sudo pacman -S i3-gaps \
  alacritty \
  pulseaudio \
  pavucontrol \
  flameshot \
  nm-applet \
  xorg \
  xorg-xinit \
  xscreensaver \
  zsh \
  go \
  blueman \
  feh \
  openssh \
  docker \
  docker-compose \
  gnome-keyring \
  network-manager-applet \
  --noconfirm

  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay

  yay -S polybar \
  deadd-notification-center-bin \
  visual-studio-code-bin \
  mpris-ctl \
  xbanish \
  snixembed-git \
  picom-jonaburg-git \
  spotify \
  google-chrome \
  nerd-fonts-jetbrains-mono \
  nerd-fonts-source-code-pro \
  nerd-fonts-fira-code \
  --noconfirm
fi