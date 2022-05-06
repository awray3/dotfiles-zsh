# Core aliases
alias vim="nvim"
alias top="btop"

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

## Jupyter book
alias jbb="jupyter-book build"

jbc () {
    jupyter-book clean $1 --all
}

alias jt="jupytext"

alias new_project="cookiecutter gh:awray3/new-project-cookiecutter"

alias ls="pls"