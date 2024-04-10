# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# setopt dotglob
setopt GLOB_DOTS

alias ls='ls -A --color=auto'
alias grep='grep --color=auto'
alias du='du -h -a -d 1'
alias poweroff='systemctl poweroff'
alias rm='rm -rf'
alias cp='cp -r'
alias rp='realpath'

alias vim=nvim
alias vimt='nvim -u /home/bae/.config/nvim/my_old_init/init.vim'

export MANPAGER='nvim -u /home/bae/.config/nvim/my_old_init/init.vim +Man!'

export GPG_TTY=$(tty)
export GCM_CREDENTIAL_STORE="gpg"

export QT_QPA_PLATFORM="wayland;xcb"

. "/home/bae/.cargo/env"
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
