# Core aliases
alias vim="nvim"
alias top="htop"

## Refreshing things
alias reloadzsh="source ~/.zshrc"
alias reloadvim="nvim +PackerSync"

## Opening configs
alias zshconf="vim $ZSH_DIR/zshrc"
alias vimconf="vim ~/.config/neovim-dotfiles/init.lua"
alias sshconf="vim ~/.ssh/config"

## Opening file types
alias -s md=code
alias -s py=code
alias -s ipynb=code

## Jupyter book
alias jbb="jupyter-book build"

jbc () {
    jupyter-book clean $1 --all
}