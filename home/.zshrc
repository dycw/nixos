# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/histfile
HISTSIZE=10000
SAVEHIST=10000
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
_EXA_ARGS='--classify --group-directories-first'
_EXA_SHORT_ARGS="$_EXA_ARGS --across"
alias l="exa $_EXA_SHORT_ARGS --git-ignore"
alias la="exa $_EXA_SHORT_ARGS --all"
_EXA_LONG_ARGS="$_EXA_ARGS --git --group --header --long --time-style=long-iso"
alias ll="exa $_EXA_LONG_ARGS --git-ignore"
alias lla="exa $_EXA_LONG_ARGS --all"
alias lal='lla'

# fd
alias fdd='fd --type=directory'
alias fde='fd --type=executable'
alias fdf='fd --type=file'
alias fds='fd --type=symlink'

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" ' 
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] &&  source ~/.fzf.zsh

# git
alias gaac='gaa && gc'
alias gap='gapa'
unalias gcm; function gcm { git commit -m "$1" && git push; }
alias gcop='git checkout -p'
alias gdm='gd && gaa && gcm'
alias gdc='gdca'
alias gdcm='gdca && gcm'
alias gs='gss'

# spotify
alias spotify='nohup spotify &'

# nix-env
function nix-env-search { nix-env -qaP '.*'"$1"'.*'; }

# vim
alias v='vim'
stty start undef     # for <C-s>, <C-q>
stty stop undef      # ...
setopt noflowcontrol # ...

# zoxide
eval "$(zoxide init zsh)"
export _ZO_EXCLUDE_DIRS=/tmp

