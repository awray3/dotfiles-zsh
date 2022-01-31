#zmodload zsh/zprof
source $HOME/.zsh/exports.zsh
source $ZSH_DIR/aliases.zsh
source $ZSH_DIR/config.zsh
source $ZSH_DIR/fzf-settings.zsh

# Set location of z installation
. $HOME/z.sh

## conda completion settings
fpath+=$ZSH_CUSTOM/conda-zsh-completion
bindkey -v
plugins=(git brew conda-zsh-completion vi-mode)

## for pipx
autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit
eval "$(register-python-argcomplete pipx)"

# Initialize oh-my-zsh. Everything above this line needs to happen before oh-my-zsh is loaded! Weird!
source $ZSH/oh-my-zsh.sh

# sets up fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

############ MCFLY SETTINGS
# hook into zsh
eval "$(mcfly init zsh)"

# Hook direnv into zsh
eval "$(direnv hook zsh)"

############## THEMES
# Path to oh-my-zsh installation.
source $THEMES/oxide.zsh-theme

# BEGIN_KITTY_SHELL_INTEGRATION
if test -e "/Applications/kitty.app/Contents/Resources/kitty/shell-integration/kitty.zsh";
  then source "/Applications/kitty.app/Contents/Resources/kitty/shell-integration/kitty.zsh";
fi
# END_KITTY_SHELL_INTEGRATION

#zprof
