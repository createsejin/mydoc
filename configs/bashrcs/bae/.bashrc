#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -A --color=auto'
alias grep='grep --color=auto'
alias du='du -h -a -d 1'
alias poweroff='systemctl poweroff'
PS1='[\u@\h \W]\$ '

shopt -s dotglob
