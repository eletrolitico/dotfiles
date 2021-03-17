#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

###################################
##### END OF DEFAULT XINITRC ######
###################################
#source "/home/henrique/.ghcup/env"
eval `dbus-launch --auto-syntax`

#tray icons (convert sni to xembed, use until polybar supports sni)
snixembed --fork &

#normal cursor
xsetroot -cursor_name left_ptr

#screensaver
xscreensaver -nosplash &

# nm-applet
nm-applet --indicator &

# Notification center
deadd-notification-center &

# Bluetooth
blueman-applet &

# Stop screen from going blank
xset s off
xset -dpms
xset s noblank

# add local binaries
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# Faster key repeat and delay
xset r rate 210 40

# Hide Cursor when typing
xbanish &

# Open flameshot on startup
flameshot &

# Monitor setup
#xrand
[ -f $HOME/dotfiles/xrand.sh ] && source $HOME/dotfiles/xrand.sh

# Wallpaper
feh --bg-fill --randomize ~/Pics/wallpapers/* &

exec i3