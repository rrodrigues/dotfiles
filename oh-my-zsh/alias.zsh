
#################################
##
##    alias
##
#################################
# helper function to create alias
function ambiguous_alias() {
  if [[ `uname` == 'Darwin' ]]; then
    alias $1=$3
  else
    alias $1=$2
  fi
}

alias espaco='df -h'
alias tamanho='du -s -h'
ambiguous_alias tamanho2 'du --max-depth=1 -h' 'du -d=1 -h'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
ambiguous_alias ls 'ls --color=auto' 'ls -G'
alias ll='ls -l'
alias la='ls -la'
alias py3='python3'

# file open alias
# alias -s py=gvim

# alias pipe grep
alias -g g='| grep '


# current dir to clipboard
alias pwd_clipboard='pwd | pbcopy'
