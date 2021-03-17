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
    
    mkdir -p $HOME/Pics/wallpapers
    
    link ".oh-my-zsh"
    link ".zshrc"
    link ".p10k.zsh"
    link_folder ".config"
    link_folder ".local"
fi

if [ $1 == "install" ] || [ $1 == "all" ]; then
    sudo pacman -Syyuu --noconfirm
    sudo pacman -S --needed sway \
    alacritty \
    grim \
    i3status \
    mako \
    slurp \
    swayidle \
    swaylock \
    wallutils \
    waybar \
    xorg-server-xwayland \
    pulseaudio \
    pavucontrol \
    zsh \
    go \
    blueman \
    openssh \
    docker \
    docker-compose \
    gnome-keyring \
    network-manager-applet \
    playerctl \
    --noconfirm
    
    sudo usermod -s /usr/bin/zsh $USER
    
    if [ ! -f "/usr/bin/yay" ]; then
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ..
        rm -rf yay
    else
        yay -Syyuu --noconfirm
    fi
    
    yay -S --needed google-chrome \
    visual-studio-code-wayland \
    spotify \
    nerd-fonts-jetbrains-mono \
    nerd-fonts-source-code-pro \
    nerd-fonts-fira-code \
    --noconfirm
fi