# A lot of these come from the omz git plugin.
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

alias ga='git add'
alias gau='git add --update'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'

alias gcb='git checkout -b'
alias gbd='git branch -d'
alias gco='git checkout'

alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glog='git log --oneline --decorate --graph'
alias gpr='git pull --rebase'

alias grm='git rm'
alias grmc='git rm --cached'

# prettier git-diff
function gd () {
    git diff $@ | dunk
}
alias gds='gd --staged'

alias gss='git status -sb'
alias gst='git status'
