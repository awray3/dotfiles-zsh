# Core aliases
alias vim="nvim"
alias top="bpytop"

## Refreshing things
alias reloadzsh="source ~/.zshrc"
alias reloadvim="nvim +PackerSync"

## Opening configs
con () {
    if [[ -v VSCODE ]]; then
        eval "$VSCODE $DOTFILES/dotfiles.code-workspace"
    else 
        echo "This system does not have vscode on path."
    fi
}


## Opening file types
# these are "suffix aliases", see https://linuxhint.com/configure-use-aliases-zsh/
alias -s md=code
alias -s py=code
alias -s ipynb=code

# script for making new myst markdown files
# idea for improvement: if conda env is active,
# automatically use that kernel instead of asking.
new_markdown () {
    $CONDA_PYTHON_EXE $ZSH_DIR/new_markdown.py $@
}
alias nmd="new_markdown"

alias js="jupytext --sync"

alias new_project="cookiecutter gh:awray3/new-project-cookiecutter"

# function/alias for installing the currently activated 
# venv as a jupyter kernel. Note that the environment variable
# CONDA_DEFAULT_ENV gives the name of the current conda env.
kernel_install () {
    ipython kernel install --user --name="$CONDA_DEFAULT_ENV"
}

alias ls="pls"
alias l="ls"