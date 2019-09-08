DEFAULT_USER=adi
export ZSH="/Users/adi/.oh-my-zsh"
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export EDITOR=nano
export PATH=~/.npm-global/bin:$PATH

ZSH_THEME="agnoster"

export UPDATE_ZSH_DAYS=5

COMPLETION_WAITING_DOTS="true"

plugins=(
  autoupdate
  autojump
  colorize
  colored-man-pages
  docker
  docker-compose
  fast-syntax-highlighting
  git
  history-substring-search
  vscode
  you-should-use
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

for file in ~/.dotfiles/zsh_files/.{aliases,functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

#kubectl-short-aliases
alias k=kubectl
complete -o default -F __start_kubectl k

# Neovim
alias vi=nvim
alias vim=nvim

#hub => git
if [ -x "$(command -v hub)" ]; then
  eval "$(hub alias -s)"
fi

if [ -x "$(command -v gel)" ]; then
  eval "$(gel shell-setup)"
fi

if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init -)"
fi

# Enable autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
