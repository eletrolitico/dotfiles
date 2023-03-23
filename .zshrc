if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# user section
DISABLE_AUTO_TITLE="true"
export BROWSER="firefox"

# kubectl completion
source <(kubectl completion zsh)

# docker & docker-compose config
export DOCKER_BUILDKIT=1
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dcl="docker-compose logs -f"
alias dce="docker-compose exec"
alias dcb="docker-compose build"

# enable color via ssh
alias ssh="TERM=xterm-256color ssh"

# golang config
export PATH=$PATH:/home/henrique/go/bin
export GOPRIVATE=gitalpha.com

# sbt config
export SBT_OPTS="-Xms4G -Xmx4G -Xss4M -XX:+CMSClassUnloadingEnabled -Dsbt.override.build.repos=true"
export SBT_CREDENTIALS=$HOME/.sbt/.credentials

#android studio config
export ANDROID_SDK_ROOT=/home/henrique/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin

#see images in terminal
alias icat="kitty +kitten icat"

export PATH=$PATH:/sbin:/usr/sbin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.yarn/bin

alias ip="ip -c"

# flutter
export PATH=$PATH:$HOME/development/flutter/bin
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable

# fix java apps
export _JAVA_AWT_WM_NONREPARENTING=1

# wayland
#export XDG_SESSION_TYPE=wayland
#export XDG_CURRENT_DESKTOP=sway
#export QT_QPA_PLATFORM='wayland' # Use wayland for QT apps
#export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
#export QT_QPA_PLATFORM_PLUGIN_PATH="/usr/lib/qt/plugins"
#export RIPCORD_STYLE_ENGINE=Fusion
#export MOZ_ENABLE_WAYLAND=1
#export MOZ_DBUS_REMOTE=1
#export GST_VAAPI_ALL_DRIVERS=1
#export OBS_USE_EGL=1

alias open="xdg-open"
alias gdev="git add . && git commit -m 'dev' && git push"
alias k="kubectl"
alias vim="nvim"
alias yx="yarn dlx"

# pnpm
export PNPM_HOME="/home/henrique/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
