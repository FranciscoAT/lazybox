EXIT_CODE="%(?..[%?] )"
TOP_BRACKET="%{$fg[red]%}┌───%{$reset_color%}"
BOTTOM_BRACKET="%{$fg[red]%}└─ ${EXIT_CODE}λ%{$reset_color%}"

CWD_PATH="%{$fg_bold[blue]%}%/%{$reset_color%}"
USER_PROMPT="%{$fg[white]%}[%n@%m]%{$reset_color%}"
TIME_PROMPT="%{$fg_bold[black]%}[%T]%{$reset_color%}"

PROMPT=$'${TOP_BRACKET} ${CWD_PATH} $(git_prompt_info)$(bzr_prompt_info)${USER_PROMPT} ${TIME_PROMPT}
${BOTTOM_BRACKET} '

PROMPT2="%{$fg_bold[black]%}%_> %{$reset_color%}"

GIT_CB="git::"
ZSH_THEME_SCM_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_PREFIX=$ZSH_THEME_SCM_PROMPT_PREFIX$GIT_CB
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
