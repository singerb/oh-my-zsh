function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±>' && return
    hg root >/dev/null 2>/dev/null && echo '☿>' && return
    echo ' >'
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function hg_prompt_info {
    hg prompt --angle-brackets "\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}\
<%{$fg[magenta]%}<branch>%{$reset_color%}>\
< tags: %{$fg[cyan]%}<tags|%{$reset_color%}, %{$fg[cyan]%}>%{$reset_color%}>\
< patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})>>" 2>/dev/null
}

local last_status="%(?,%fg[green]%}✓%{$reset_color%},%{$fg[red]%}✕%{$reset_color%})"

PROMPT='%{$fg_no_bold[magenta]%}%n%{$reset_color%}@%{$fg_no_bold[cyan]%}%m%{$reset_color%}:%{$fg_no_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}
$(virtualenv_info)%{$fg_bold[red]%}$(vi_mode_prompt_info)%{$reset_color%}%{$fg_no_bold[blue]%}%D %T%{$reset_color%} %(?,%{$fg_no_bold[green]%}✓%{$reset_color%},%{$fg_no_bold[red]%}✕%{$reset_color%})$(prompt_char) '

RPROMPT=$'$(hg_prompt_info)$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
