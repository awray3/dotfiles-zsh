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

. $ZSH_DIR/jupyter.zsh
. $ZSH_DIR/conda.zsh
. $ZSH_DIR/git.zsh

alias ls="pls"
alias l="ls"
