####    using Arch Linux grml package

####    copied from grml .zshrc
# set colors for use in prompts
if zrcautoload colors && colors 2>/dev/null ; then
    BLUE="%{${fg[blue]}%}"
    RED="%{${fg_bold[red]}%}"
    GREEN="%{${fg[green]}%}"
    CYAN="%{${fg[cyan]}%}"
    MAGENTA="%{${fg[magenta]}%}"
    YELLOW="%{${fg[yellow]}%}"
    WHITE="%{${fg[white]}%}"
    NO_COLOUR="%{${reset_color}%}"
else
    BLUE=$'%{\e[1;34m%}'
    RED=$'%{\e[1;31m%}'
    GREEN=$'%{\e[1;32m%}'
    CYAN=$'%{\e[1;36m%}'
    WHITE=$'%{\e[1;37m%}'
    MAGENTA=$'%{\e[1;35m%}'
    YELLOW=$'%{\e[1;33m%}'
    NO_COLOUR=$'%{\e[0m%}'
fi

####    my PROMPT

if (( EUID != 0 )); then
    PROMPT_COLOUR=${BLUE};
else
    PROMPT_COLOUR=${RED};
fi

PROMPT="${PROMPT_COLOUR}%B%20<...<%~%b${NO_COLOUR} " 
PROMPT="${PROMPT}"'${vcs_info_msg_0_}'"%# "

####    my alias
alias espaco='df -h'
alias tamanho='du -s -h'

####    my funcs

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


#### Pacman alias & Pacman commands
alias pacupg='sudo pacman -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias pacin='sudo pacman -S'           # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'          # Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'              # Display information about a given package in the repositories
alias pacreps='pacman -Ss'             # Search for package(s) in the repositories
alias pacloc='pacman -Qi'              # Display information about a given package in the local database
alias paclocs='pacman -Qs'             # Search for package(s) in the local database

# Additional pacman alias examples
#alias pacupd='sudo pacman -Sy && sudo abs'     # Update and refresh the local package and ABS databases against repositories
#alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
#alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
