# shellcheck disable=SC2034
DEFAULT_USER=adi

export ZSH="/Users/adi/.oh-my-zsh"

export GOPATH=$HOME
export GO111MODULE=on

export EDITOR=nano
export PATH=~/.npm-global/bin:$GOPATH/bin:/usr/local/sbin:$PATH

export DOCKER_BUILDKIT=1

# shellcheck disable=SC2034
ZSH_THEME="spaceship"

export UPDATE_ZSH_DAYS=5


# shellcheck disable=SC2034
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

# shellcheck disable=SC1090
source $ZSH/oh-my-zsh.sh

# shellcheck disable=SC1091
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; 
fi

# shellcheck disable=SC1091
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; 
fi

# shellcheck disable=SC1090
for file in ~/.dotfiles/zsh_files/.{aliases,functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

#kubectl-short-aliases
alias k=kubectl

# Neovim
alias vi=nvim
alias vim=nvim

#hub => git
if [ -x "$(command -v hub)" ]; then
  eval "$(hub alias -s)"
fi

if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init -)"
fi

# shellcheck disable=SC1091
# load dev, but only if present
if [ -f '/opt/dev/dev.sh' ]; then
  source '/opt/dev/dev.sh';
fi

export KUBECONFIG=/Users/adi/.kube/config.shopify.cloudplatform:/Users/adi/.kube/config
