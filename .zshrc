DEFAULT_USER=adi
export ZSH="/Users/adi/.oh-my-zsh"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export EDITOR=nano


ZSH_THEME="agnoster"

export UPDATE_ZSH_DAYS=5

COMPLETION_WAITING_DOTS="true"


plugins=(
  git
  docker 
  colorize
  colored-man-pages
)

source $ZSH/oh-my-zsh.sh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'


if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
for file in ~/.dotfiles/.{aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;