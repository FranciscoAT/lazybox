# -*- sh -*- vim:set ft=sh ai et sw=4 sts=4:
PROMPT='%{$fg_bold[green]%}%n%{$reset_color%}:%F{240}[%f%{$fg_bold[blue]%}%~%F{240}]%f$(git_prompt_info)%{$reset_color%} %(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX=" ➜ %{$fg[red]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%}"
