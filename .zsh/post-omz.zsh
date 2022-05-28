#                  _         ___  __  __ _____
#  _ __   ___  ___| |_      / _ \|  \/  |__  /
# | '_ \ / _ \/ __| __|____| | | | |\/| | / / 
# | |_) | (_) \__ \ ||_____| |_| | |  | |/ /_ 
# | .__/ \___/|___/\__|     \___/|_|  |_/____|
# |_|                                         

if command -v aws &>/dev/null
then 
    complete -C '/usr/local/bin/aws_completer' aws
fi

if command -v starship &>/dev/null
then
    eval "$(starship init zsh)"
fi

# Set up Mcfly
if command -v mcfly &> /dev/null
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
if command -v direnv &> /dev/null
then 
    eval "$(direnv hook zsh)"
else
    if [[ -v DEBUG_CONFIG_FLAG ]]
    then
        echo "direnv not installed."
    fi
fi

# set up zsh syntax highlighting
# NOTE: This may need to come last after all other things are sourced?
if ! [[ -d "$ZSH_DIR/zsh-syntax-highlighting" ]]
then
    echo "zsh-syntax-highlighting not found. cloning."
    git clone \
    https://github.com/zsh-users/zsh-syntax-highlighting.git \
    $ZSH_DIR/zsh-syntax-highlighting
fi
source $ZSH_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh