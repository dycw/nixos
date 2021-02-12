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
fi

# git
alias gdc='git diff --cached'
alias gs='git status -s'

# vim
# to enable <C-s> and <C-q>
stty start undef
stty stop undef
setopt noflowcontrol
