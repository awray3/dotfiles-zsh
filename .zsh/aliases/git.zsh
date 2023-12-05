# A lot of these come from the omz git plugin.
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

export GIT_BIN=/opt/homebrew/bin/git

# alias git=git
alias gs="git-sim"

alias ga='git add'
alias gau='git add --update'
alias gc='git commit -v'
alias gca='git commit -v --amend'
alias gcan='git commit -v --no-edit --amend'

alias gcb='git checkout -b'
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'


git_log() {
    DEFAULT_LINES=5
    num_lines=$1
    # if no number is passed in, set it to the default.
    if [ -z "$num_lines" ]
    then
        num_lines=$DEFAULT_LINES
    else
        shift
    fi

    git log --oneline --decorate --max-count=$num_lines $@
}

alias glo=git_log
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

alias gr='git restore'
alias grs='git restore --staged'

alias lg='lazygit'


