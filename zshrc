# add to path
typeset -U path

# /usr/local/bin first
export PATH="/usr/local/bin:$PATH"

export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

###############
#
#   loading stuff
#
###############

autoload -U compinit promptinit
compinit
promptinit

# autocomplete
autoload -U compinit
compinit

# renaming
autoload -U zmv


#####

no_color=$'%{\e[0m%}'
init_color=${no_color}
if (( EUID == 0 )); then
  init_color=$'%{\e[1;31m%}'
fi

PROMPT="${init_color}%c %#${no_color} "
# autocomplete arrow-key driver interface
# show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2

# autocomplete switch for aliases
setopt completealiases


# keybinds
#bindkey -v # vim mode
bindkey -e # emacs mode
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# fix shit-tab press
bindkey '^[[Z' reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi


# history search
autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"      ]]  && bindkey   "${key[Up]}"       up-line-or-beginning-search
[[ -n "${key[Down]}"    ]]  && bindkey   "${key[Down]}"    down-line-or-beginning-search


# history
HISTFILE=~/.history
HISTSIZE=1000
SAVEHIST=1000
# same history for different zsh's
#setopt SHARE_HISTORY
setopt APPEND_HISTORY

# prevent from putting duplicate lines in the history
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# go to dir without cd at the beggining
setopt AUTO_CD

# correct command
setopt CORRECT


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

# file open alias
alias -s py=gvim

# alias pipe grep
alias -g g='| grep '


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

# add sudo to the beggining of command - ESC-s
insert_sudo() { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo # esc-s

# cd and ls in one
cl() {
    dir=$1
    if [[ -z "$dir" ]]; then
        dir=$HOME
    fi
    if [[ -d "$dir" ]]; then
        cd "$dir"
        ls
    else
        echo "bash: cl: '$dir': Directory not found"
    fi
}

extract() {

    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1
        a=''
        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
        *.tar.bz2)  c='tar'; a='xvjf' ;;
        *.tar.gz)   c='tar'; a='xvzf' ;;
        *.tar)      c='tar'; a='xvf' ;;
        *.tbz2)     c='tar'; a='xvjf' ;;
        *.tgz)      c='tar'; a='xvzf' ;;
        *.7z)       c='7z'; a='x';;
        *.Z)        c='uncompress';;
        *.bz2)      c='bunzip2';;
        *.exe)      c='cabextract';;
        *.gz)       c='gunzip';;
        *.rar)      c='unrar x';;
        *.xz)       c='unxz';;
        *.zip)      c='unzip';;
        *)     echo "$0: unrecognized file extension: \`$i'" >&2
               continue;;
        esac
        echo $c $a "$i"
        command $c $a "$i"
        e=$?
    done

    return $e
}

#A function to make adding flags or prefixing arguments easier:
# Move to where the arguments belong.
after-first-word() {
  zle beginning-of-line
  zle forward-word
}
zle -N after-first-word
bindkey "^[a" after-first-word # esc-a


# test func









