# configs
alias zshconf="vim ~/.zshrc"
alias vimconf="vim $NEOHOME/init.vim"
alias tmuxconf="vim ~/.tmux.conf"
alias sshconf="vim ~/.ssh/config"
alias kittyconf="vim $KITTYHOME/kitty.conf"
alias utconf="vim $UNTRACKED_ZSHRC"
alias rangerconf="vim $CONFIG/ranger/rifle.conf"

# Aliases for the config command.
# This creates a command called "config"
# that is aliaased to git for the bare dotfiles repo.
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias co='config'
alias coco='config commit -v'
alias cost='config status'
alias coau='config add -u'
alias copu='config push'
alias copl='config pull'


############# Untracked files
# These contain aliases I don't want in
# version control
source $UNTRACKED_ZSHRC
