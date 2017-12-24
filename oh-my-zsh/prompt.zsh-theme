
if [[ -z "$SSH_CLIENT" ]]; then
  prompt_host=""
else
  prompt_host="%{$fg_bold[green]%}$USER@%m"
fi

PROMPT='${prompt_host}%{$fg[blue]%} %c $(git_prompt_info)%$(git_prompt_status) %#%{$reset_color%} '



ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}) "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}) "

ZSH_THEME_GIT_PROMPT_ADDED=" ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹"
ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭"

