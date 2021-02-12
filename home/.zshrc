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

# fzf
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" ' 
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# git
alias gcm='git commit -m'
alias gdc='git diff --cached'
alias gs='git status -s'

# nix-env
function nix-env-search { nix-env -qaP '.*'"$1"'.*'; }

# vim
# to enable <C-s> and <C-q>
stty start undef
stty stop undef
setopt noflowcontrol

# zoxide
eval "$(zoxide init zsh)"
export _ZO_EXCLUDE_DIRS=/tmp

