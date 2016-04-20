
#################################
##
##    functions
##
#################################

# Ctrl-z to store current command.
# after next comment, the stored command will be replaced
fancy-ctrl-z () {
  emulate -LR zsh
  if [[ $#BUFFER -eq 0 ]]; then
    bg
    zle redisplay
  else
    zle push-input
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z'          fancy-ctrl-z # ctrl-z
