# A lot of these come from the omz git plugin.
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

export GIT_BIN=/opt/homebrew/bin/git

g() {
    if [[ $# -eq 0 ]]; then
        git status
    else
        git "$@"
    fi
}

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

alias gpl='git pull'
alias gpr='git pull --rebase'

alias gpu='git push'

alias grm='git rm'
alias grmc='git rm --cached'

# diff settings

diff_with_notebooks() {
  
  
  if [[ "$1" == "--no-nb" ]]; then
    # Remove the flag from the arguments list
    shift

    # Message indicating skipping of .ipynb diffs
    git diff --name-only $@ -- '*.ipynb' | \
      xargs -I {} echo 'modified: {} (output skipped)'
  else
    local git_root=$(git rev-parse --show-toplevel)  # Find the root directory of the Git repository
    local original_dir="$(pwd)" # Store the original directory

    cd "$git_root" || return  # Change to the root directory of the Git repository 
    
    # Diff for .ipynb files using nbdime
    git diff --name-only $@ -- '*.ipynb' | \
      xargs -I {} nbdiff {} -OMAD

    cd "$original_dir"
  fi

  # Diff for non-.ipynb files using regular git diff
  git diff $@ -- ':(exclude)*.ipynb'; 
}

alias gd="diff_with_notebooks"
alias gdn="diff_with_notebooks --no-nb"
alias gds='gd --staged'

alias gss='git status -sb'
alias gst='git status'

alias gr='git restore'
alias grs='git restore --staged'

alias lg='lazygit'


# DVC aliases
d() {
  output=$(dvc status 2>&1)
  if [[ $? -eq 0 ]]; then
    if [[ $# -eq 0 ]]; then
      echo "$output"
    else
      dvc "$@"
    fi
  else
    echo "Not in a DVC repo."
  fi
}

alias da='dvc add'
alias dc='dvc commit'
alias dst='dvc status'
alias dr='dvc repro --no-commit'
alias drc='dvc repro'
alias dco='dvc checkout'
alias dgc='dvc gc'
alias dpu='dvc push'
alias dpl='dvc pull'
