# A lot of these come from the omz _git plugin.
# https://_github.com/ohmyzsh/ohmyzsh/blob/master/plugins/_git/_git.plugin.zsh

export GIT_BIN=/opt/homebrew/bin/git

# wraps _git so that it will accept --sim as an optional arg
# to use _git-sim instead
_git ()
{
    # I have the option of using an environment variable instead
    local use_sim=${USE_GIT_SIM}

    local args=("$@")
    if [[ ${args[-1]} == "--sim" ]]; then
        use_sim=1
        args=("${args[@]:0:$((${#args[@]} -1))}")
    fi

    if [[ -z "$use_sim" ]]; then
        git "${args[@]}"
    else
        git-sim "${args[@]}"
    fi
}

alias git=_git
alias gs="git-sim"

alias ga='_git add'
alias gau='_git add --update'
alias gc='_git commit -v'
alias gca='_git commit -v --amend'
alias gcan='_git commit -v --no-edit --amend'

alias gcb='_git checkout -b'
alias gb='_git branch'
alias gbd='_git branch -d'
alias gbD='_git branch -D'
alias gco='_git checkout'


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

    _git log --oneline --decorate --max-count=$num_lines $@
}

alias glo=git_log
alias glol="_git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glog='_git log --oneline --decorate --graph'
alias gpr='_git pull --rebase'

alias grm='_git rm'
alias grmc='_git rm --cached'

# prettier _git-diff
function gd () {
    _git diff $@ | dunk
}
alias gds='gd --staged'

alias gss='_git status -sb'
alias gst='_git status'

alias gr='_git restore'
alias grs='_git restore --staged'

alias lg='lazygit'


