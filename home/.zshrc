# shellcheck shell=bash
# shellcheck source=/dev/null

# Lines configured by zsh-newuser-install
export HISTFILE=~/.cache/zsh/histfile
HISTSIZE=10000
export SAVEHIST=10000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/derek/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# bat
alias cat='bat'

# cd
alias cddf='cd ~/.dotfiles'
alias cddl='cd ~/Downloads'
alias cdw='cd ~/work'

# exa
alias _exa_base='exa --classify --group-directories-first'
alias _exa_short='_exa_base --across'
alias l='_exa_short --git-ignore'
alias la='_exa_short --all'
alias _exa_long='_exa_base --git --group --header --long --time-style=long-iso'
alias ll='_exa_long --git-ignore'
alias lla='_exa_long --all'
alias lal='lla'

# fd
alias fd='fd -H'
alias fdd='fd -t=d'
alias fde='fd -t=e'
alias fdf='fd -t=f'
alias fds='fd -t=s'

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# git
alias gaac='gaa && gc'
alias gap='gapa'
unalias gcm
function gcm() { git commit -m "$1" && git push; }
alias gcop='git checkout -p'
alias gdm='gd && gaa && gcm'
alias gdc='gdca'
alias gdcm='gdca && gcm'
alias gl='glols'
alias gll='glgp'
alias gpl='git pull'
alias gs='gss'

# spotify
alias spotify='nohup spotify &'

# nix-env
function nix-env-search() { nix-env -qaP '.*'"$1"'.*'; }

# vim
alias v='vim'
stty start undef     # for <C-s>, <C-q>
stty stop undef      # ...
setopt noflowcontrol # ...

# zoxide
eval "$(zoxide init zsh)"
export _ZO_EXCLUDE_DIRS=/tmp
