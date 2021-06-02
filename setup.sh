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

print_array()
{
  arr=("$@")
  i=0
  for e in "${arr[@]}"; do
    echo "$i: $e"
    i=$((i+1))
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

  XRAN_FILE="xrand.sh"

  if [ ! -f $XRAN_FILE ]; then
    MONITORS=($(xrandr | grep ".* connected" | cut -d ' ' -f1))
    print_array ${MONITORS[@]}
    printf "Choose the primary monitor(type the number): "
    read prM
    printf 'xrandr' > $XRAN_FILE

    MODES=("--right-of" "--left-of" "--above" "--below")
    I=0
    for m in "${MONITORS[@]}"; do

      if [ $I -eq $prM ]; then
        echo -ne " --output ${MONITORS[I]} --primary --auto" >> $XRAN_FILE
      else

        printf "\n\n${MONITORS[I]} is:\n"
        printf "0: right-of\n1: left-of\n2: above\n3: below\noption: "
        read mod

        printf "\n\nwhich monitor:\n"
        print_array ${MONITORS[@]}
        printf "option: "
        read mon

        echo -ne " --output ${MONITORS[I]} --auto ${MODES[mod]} ${MONITORS[mon]}" >> $XRAN_FILE
      fi
      I=$(($I+1))
    done
  fi

  mkdir -p $HOME/Pictures/wallpapers

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
  pipewire-pulse \
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
  picom \
  --noconfirm

  if [ ! -f "/usr/bin/yay" ]; then
      git clone https://aur.archlinux.org/yay.git
      cd yay
      makepkg -si --noconfirm
      cd ..
      rm -rf yay
  else
      yay -Syyuu --noconfirm
  fi

  yay -S polybar \
  deadd-notification-center-bin \
  visual-studio-code-bin \
  mpris-ctl \
  xbanish \
  snixembed-git \
  spotify \
  google-chrome \
  nerd-fonts-jetbrains-mono \
  nerd-fonts-source-code-pro \
  nerd-fonts-fira-code \
  --noconfirm
fi