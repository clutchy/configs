alias nrd='npm run dev'
alias nrl='npm run lint'
alias nrb='npm run build'
alias nrs='npm run start'

source /usr/share/bash-completion/completions/git
alias gst='git status'
__git_complete gst _git_status
alias gc='git commit -m'
__git_complete gc _git_commit
alias gco='git checkout'
__git_complete gco _git_checkout
alias gpush='git push'
__git_complete gpush _git_push
alias gpull='git pull'
__git_complete gpull _git_pull
alias gb='git branch'
__git_complete gb _git_branch
alias gstash='git stash'
__git_complete gstash _git_stash
alias gf='git fetch'
__git_complete gf _git_fetch

alias sai='sudo apt install -y'
alias rsn='node -r @swc-node/register'

