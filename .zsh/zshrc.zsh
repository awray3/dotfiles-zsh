#            _              
#    _______| |__  _ __ ___ 
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__ 
# (_)___|___/_| |_|_|  \___|
#

if [[ -v DEBUG_CONFIG_FLAG ]]
then 
  echo "Loading config in debug mode."
  zmodload zsh/zprof
fi

#        _   _ _     
#  _   _| |_(_) |___ 
# | | | | __| | / __|
# | |_| | |_| | \__ \
#  \__,_|\__|_|_|___/

command_on_path () {
  command -v $1 &>/dev/null
}

#                             _       
#   _____  ___ __   ___  _ __| |_ ___ 
#  / _ \ \/ / '_ \ / _ \| '__| __/ __|
# |  __/>  <| |_) | (_) | |  | |_\__ \
#  \___/_/\_\ .__/ \___/|_|   \__|___/
#           |_|                       

# Set default editor to nvim
export EDITOR='nvim'
export VISUAL='neovide'

# directory aliases
# export ZSH=$HOME/.oh-my-zsh
export ZSH=$HOME/.zsh
export ZSH_PLUGINS=$ZSH/plugins
export NEOHOME=$HOME/.config/nvim
export KITTYHOME=$HOME/.config/kitty
export DOTFILES=$HOME/dotfiles

#        _ _                     
#   __ _| (_) __ _ ___  ___  ___ 
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/

# Core aliases
alias vim="neovide"
alias top="bpytop"

## Refreshing things
alias reloadzsh="source ~/.zshrc"
alias vims="nvim +PackerSync"

# experimental jukit alias 
alias jukit_kitty="kitty --listen-on=unix:@'$(date +%s%N)' -o allow_remote_control=yes"

## Opening configs
con () {
    if [[ -v VSCODE ]]; then
        eval "$VSCODE $DOTFILES/dotfiles.code-workspace"
    else 
        echo "VScode is not on path."
    fi
}

. $ZSH/aliases/jupyter.zsh
. $ZSH/aliases/conda.zsh
. $ZSH/aliases/git.zsh
. $ZSH/aliases/fzf-settings.zsh

alias ls="lsd --config-file $ZSH/lsd.yaml"
alias l="ls -l"
alias la="ls -la"

alias cl="clear"

alias cat="bat -p"
alias j="just"

# sets vi keybindings on the command line
bindkey -v

# I think this makes completion case insensitive
setopt no_list_ambiguous

#                                                _     
#   ___ ___  _ __ ___  _ __ ___   __ _ _ __   __| |___ 
#  / __/ _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
# | (_| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
#  \___\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/


# BEGIN_KITTY_SHELL_INTEGRATION
KITTY_ZSH_FILE=/Applications/kitty.app/Contents/Resources/kitty/shell-integration/zsh/kitty.zsh
if test -e "$KITTY_ZSH_FILE";
  then
    source $KITTY_ZSH_FILE
    export KITTYHOME=$CONFIG/kitty
    alias kittyconf="vim $KITTYHOME/kitty.conf"
fi
# END_KITTY_SHELL_INTEGRATION


## Ripgrep
if ! command_on_path rg && [[ -v DEBUG_CONFIG_FLAG ]]
then
  echo "Missing ripgrep. You can probably sudo apt-get ripgrep or brew install ripgrep."
fi

# Set up untracked files
LOCAL_ONLY_CONFIG="$HOME/.local_only"
if [[ -d "$LOCAL_ONLY_CONFIG" ]]
then
    if [[ -f "$LOCAL_ONLY_CONFIG/zshrc" ]]
    then 
        source $LOCAL_ONLY_CONFIG/zshrc
    fi
fi

# Sets up node version manager (nvm)
if [[ -d "$HOME/.nvm" ]]
then
  export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  if [[ -v DEBUG_CONFIG_FLAG ]]
  then 
    echo "nvm is installed."
  fi
elif [[ -v DEBUG_CONFIG_FLAG ]]
then 
  echo "nvm is not installed."
fi

if command_on_path starship
then
    eval "$(starship init zsh)"
fi

# Set up Mcfly
if command_on_path mcfly
then 
    export MCFLY_KEY_SCHEME=vim
    export MCFLY_FUZZY=true
    eval "$(mcfly init zsh)"
else 
    if [[ -v DEBUG_CONFIG_FLAG ]]
    then 
        echo "Mcfly is not installed. You can install mcfly by running the below command."
        echo "curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --git cantino/mcfly"
    fi
fi

# set up direnv
if command_on_path direnv
then 
    eval "$(direnv hook zsh)"
else
    if [[ -v DEBUG_CONFIG_FLAG ]]
    then
        echo "direnv not installed."
    fi
fi

#        _             _           
#  _ __ | |_   _  __ _(_)_ __  ___ 
# | '_ \| | | | |/ _` | | '_ \/ __|
# | |_) | | |_| | (_| | | | | \__ \
# | .__/|_|\__,_|\__, |_|_| |_|___/
# |_|            |___/             


# set up zsh syntax highlighting
# NOTE: This may need to come last after all other things are sourced?
SYNTAX_HILITE_PATH=$ZSH_PLUGINS/zsh-syntax-highlighting
if ! [[ -d "$SYNTAX_HILITE_PATH" ]]
then
    echo "zsh-syntax-highlighting not found. cloning."
    git clone \
    https://github.com/zsh-users/zsh-syntax-highlighting.git \
    $SYNTAX_HILITE_PATH
fi
source $SYNTAX_HILITE_PATH/zsh-syntax-highlighting.zsh

## zsh-autosuggestions
AUTOSUGGEST_PATH=$ZSH_PLUGINS/zsh-autosuggestions
if ! [[ -d "$AUTOSUGGEST_PATH" ]]
then 
  git clone https://github.com/zsh-users/zsh-autosuggestions $AUTOSUGGEST_PATH
else
  source $AUTOSUGGEST_PATH/zsh-autosuggestions.zsh
fi

# Sets up conda zsh completion
CONDA_ZSH_COMP_PATH=$ZSH_PLUGINS/conda-zsh-completion
if ! [[ -d "$CONDA_ZSH_COMP_PATH" ]]
then
  echo "conda zsh completion not found; checking out from github.com/esc/conda-zsh.completion"
  git clone https://github.com/esc/conda-zsh-completion ${CONDA_ZSH_COMP_PATH}
fi
fpath+=$CONDA_ZSH_COMP_PATH

# Install z
Z_SCRIPT_FILE=$ZSH_PLUGINS/z.sh
if ! [[ -f $Z_SCRIPT_FILE ]]
then
  echo "z is missing; installing from https://raw.githubusercontent.com/rupa/z/master/z.sh."
  curl -s https://raw.githubusercontent.com/rupa/z/master/z.sh > $Z_SCRIPT_FILE
  echo "Done."
fi
source $Z_SCRIPT_FILE


#                            _      _   _                 
#   ___ ___  _ __ ___  _ __ | | ___| |_(_) ___  _ __  ___ 
#  / __/ _ \| '_ ` _ \| '_ \| |/ _ \ __| |/ _ \| '_ \/ __|
# | (_| (_) | | | | | | |_) | |  __/ |_| | (_) | | | \__ \
#  \___\___/|_| |_| |_| .__/|_|\___|\__|_|\___/|_| |_|___/
#                     |_|                                 
# I think this makes sure that anything installed by homebrew
# gets loaded by the system zsh.
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit
autoload -Uz complete


## for pipx
if command_on_path pipx
then
  export PATH="$PATH:/home/andrew/.local/bin"
  eval "$(register-python-argcomplete pipx)"
else
  if [[ -v DEBUG_CONFIG_FLAG ]]
  then echo "pipx not installed."
  fi
fi


if command_on_path aws
then 
    complete -C '/usr/local/bin/aws_completer' aws
fi

#                 _ 
#   ___ _ __   __| |
#  / _ \ '_ \ / _` |
# |  __/ | | | (_| |
#  \___|_| |_|\__,_|


if [[ -v DEBUG_CONFIG_FLAG ]]
then 
  zprof
fi
