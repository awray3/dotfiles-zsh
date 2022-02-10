# This file stores setup config for many different tools.
# Currently supported:
# z
# conda-zsh-completion
# pipx
# poetry
# pyenv
# kitty
# mcfly
# direnv
# ranger


# Install z
Z_SCRIPT_FILE=$HOME/z.sh
if ! [[ -f $Z_SCRIPT_FILE ]]
then
  echo "z is missing; installing from https://raw.githubusercontent.com/rupa/z/master/z.sh."
  curl -s https://raw.githubusercontent.com/rupa/z/master/z.sh > $Z_SCRIPT_FILE
  echo "Done."
fi
source $Z_SCRIPT_FILE



# sets up ZSH_CUSTOM location if it doesn't already exist
if [[ -z "$ZSH_CUSTOM" ]]
then
  export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
fi

# Sets up conda zsh completion
CONDA_ZSH_COMP_PATH=$ZSH_CUSTOM/plugins/conda-zsh-completion
if ! [[ -d "$CONDA_ZSH_COMP_PATH" ]]
then
  echo "conda zsh completion not found; checking out from github.com/esc/conda-zsh.completion"
  git clone https://github.com/esc/conda-zsh-completion ${CONDA_ZSH_COMP_PATH}
fi
fpath+=$CONDA_ZSH_COMP_PATH

# BEGIN_KITTY_SHELL_INTEGRATION
if test -e "/Applications/kitty.app/Contents/Resources/kitty/shell-integration/kitty.zsh";
  then
    source "/Applications/kitty.app/Contents/Resources/kitty/shell-integration/kitty.zsh";
    export KITTYHOME=$CONFIG/kitty
    alias kittyconf="vim $KITTYHOME/kitty.conf"
fi
# END_KITTY_SHELL_INTEGRATION

# Set up Mcfly
if command -v mcfly &> /dev/null
then 
  export MCFLY_KEY_SCHEME=vim
  export MCFLY_FUZZY=true
  eval "$(mcfly init zsh)"
else 
  if $DEBUG_CONFIG_FLAG
  then 
    echo "Mcfly is not installed. You can install mcfly by running the below command."
    echo "curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --git cantino/mcfly"
  fi
fi

# set up direnv
if command -v direnv &> /dev/null
then 
  eval "$(direnv hook zsh)"
else
  if $DEBUG_CONFIG_FLAG
  then
    echo "direnv not installed."
  fi
fi

# set up Pyenv
if [[ -x "$HOME/.pyenv/bin/pyenv" ]]
then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
else
  if $DEBUG_CONFIG_FLAG
  then echo "pyenv was not found at $HOME/.pyenv as expected."
  fi
fi

## for pipx
if [[ -x "$HOME/.local/bin/pipx" ]]
then
  export PATH="$PATH:/home/andrew/.local/bin"
  autoload -U compinit && compinit
  autoload -U bashcompinit && bashcompinit
  eval "$(register-python-argcomplete pipx)"
else
  if $DEBUG_CONFIG_FLAG
  then echo "pipx not installed."
  fi
fi

# Set up Poetry
if [[ -d "$HOME/.poetry/bin" ]]
then 
  export PATH="$HOME/.poetry/bin:$PATH"
else
  if $DEBUG_CONFIG_FLAG
  then echo "Poetry not installed."
  fi
fi

## Ripgrep
if ! command -v rg &> /dev/null && $DEBUG_CONFIG_FLAG
then
  echo "Missing ripgrep. You can probably sudo apt-get ripgrep or brew install ripgrep."
fi

# Ranger
if command -v ranger &> /dev/null
then
    alias rangerconf="vim $CONFIG/ranger/rifle.conf"
fi

## zsh-autosuggestions
if ! [[ -d "$ZSH_DIR/zsh-autosuggestions" ]]
then 
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_DIR/zsh-autosuggestions
else
  source $ZSH_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


# Set up untracked files
export LOCAL_ONLY_CONFIG="$HOME/.local_only"
if [[ -d "$LOCAL_ONLY_CONFIG" ]]
then
    if [[ -f "$LOCAL_ONLY_CONFIG/zshrc" ]]
    then 
        source $LOCAL_ONLY_CONFIG/zshrc
    fi
fi

# Warning that I might be on an old config
if [[ -d "$HOME/.untracked" ]]
then
    echo "It appears you have configs in ~/.untracked on this machine."
    echo "Migrate to new configuration by renaming it to ~/.local_only."
fi
