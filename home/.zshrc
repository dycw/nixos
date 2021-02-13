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

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nix-env
function nix-env-search() { nix-env -qaP '.*'"$1"'.*'; }

# vim
stty start undef     # for <C-s>, <C-q>
stty stop undef      # ...
setopt noflowcontrol # ...

# zoxide
eval "$(zoxide init zsh)"
export _ZO_EXCLUDE_DIRS=/tmp
