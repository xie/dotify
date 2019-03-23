DEFAULT_USER=adi
export ZSH="/Users/adi/.oh-my-zsh"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export EDITOR=nano
export PATH=~/.npm-global/bin:$PATH

ZSH_THEME="agnoster"

export UPDATE_ZSH_DAYS=5

COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  colorize
  colored-man-pages
  docker-compose
  docker
)

source $ZSH/oh-my-zsh.sh

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

#kubectl-short-aliases
alias k=kubectl
complete -o default -F __start_kubectl k

#hub => git
alias git=hub

eval "$(rbenv init -)"

