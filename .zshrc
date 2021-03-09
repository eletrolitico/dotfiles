if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/henrique/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#user section
[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)

export PATH=$PATH:/home/henrique/go/bin
export GOPRIVATE="gitalpha.com"
export SBT_OPTS="-Xms4G -Xmx4G -Xss4M -XX:+CMSClassUnloadingEnabled -Dsbt.override.build.repos=true"
export SBT_CREDENTIALS=$HOME/.sbt/.credentials

export DOCKER_BUILDKIT=1
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dcl="docker-compose logs -f"
alias dce="docker-compose exec"
alias dcb="docker-compose build"

alias ssh="TERM=xterm ssh"

alias avd="/home/henrique/.config/Android/Sdk/emulator/emulator -avd Pixel_3a_API_30_x86 -netfast -accel on -gpu host -qemu -m 2048"
[ -f "/home/henrique/.ghcup/env" ] && source "/home/henrique/.ghcup/env" # ghcup-env

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
