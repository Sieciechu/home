# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions



# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
export PROMPT_COMMAND='history -a'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=80000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lhF'
alias la='ls -A'
alias l='ls -CF'
alias vim='vimx'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion.d ] && ! shopt -oq posix; then
    . /etc/bash_completion.d
fi

PS1="[\u@\h \W]\\$ "

# Internal helper: determines the branch name
__gri_pick_branch() {
    local branch="$1"

    if [ -z "$branch" ]; then
        if git show-ref --verify --quiet refs/heads/master; then
            branch="master"
        fi

        if git show-ref --verify --quiet refs/heads/main; then
            branch="main"
        fi
    fi

    printf "%s" "$branch"
}

# Rebase onto origin/<branch>
grio() {
    local branch
    branch="$(__gri_pick_branch "$@")"

    echo "git rebase origin/${branch} --interactive"
    git rebase "origin/${branch}" --interactive
}

# Rebase onto <branch> (local)
gri() {
    local branch
    branch="$(__gri_pick_branch "$@")"

    echo "git rebase ${branch} --interactive"
    git rebase "${branch}" --interactive
}

