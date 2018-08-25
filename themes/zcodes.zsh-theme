# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# Forked from ys.zsh-theme on 2016-01-17


# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$YS_VCS_PROMPT_DIRTY"
		else
			echo -n "$YS_VCS_PROMPT_CLEAN"
		fi
		echo -n "$YS_VCS_PROMPT_SUFFIX"
	fi
}

# C:$exit_code
#local exit_code="%(?,%?,%{$fg[red]%}%?%{$reset_color})"

# virtualenv info
YS_VIRTUALENV_PREFIX1=" %{$terminfo[bold]$fg[white]%}#"
YS_VIRTUALENV_PREFIX2="%{$fg[white]%}"
YS_VIRTUALENV_SUFFIX="%{$fg[white]%}#%{$reset_color%} "

local virtualenv_info='$(ys_virtualenv_info)'
ys_virtualenv_info() {
    if [ -d "$VIRTUAL_ENV" ]; then
        echo -n "${YS_VIRTUALENV_PREFIX1}"
        echo -n "${YS_VIRTUALENV_PREFIX2}"
        echo -n `basename "$VIRTUAL_ENV"`
        echo -n "${YS_VIRTUALENV_SUFFIX}"
    fi
}

PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#, %{$bg[yellow]%}%{$fg[cyan]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$fg[white]%}@ \
%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
${git_info} \
${virtualenv_info}\
%{$fg[white]%}[%*]
%{$terminfo[bold]$fg[white]%}=> %{$reset_color%}"
