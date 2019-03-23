#!/usr/bin/env zsh

source resources.sh

bot "hello! welcome to your new computer"
bot "let's get going! "

bot "installing osx command line tools"
xcode-select --install

# set computer info
set_computer_info

# copy dotfiles
mkdir ~/.dotfiles/
cp config/.* ~/.dotfiles/
cp zsh_files/.* ~/.dotfiles/
cp .zshrc ~/.dotfiles/

# homebrew
if [ -x /usr/local/bin/brew ];
then
    running "Skipping install of brew. It is already installed.";
    running "Updating brew..."
    brew update;
    running "Updated brew."
    ok
else
    running "installing brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [[ $? != 0 ]]; then
        error "unable to install homebrew -> quitting setup"
        exit 2
    fi
    ok
fi

running "Running brew bundle...";
brew bundle;
if [[ $? != 0 ]]; then
        error "brew bundle could not complete"
        exit 2
fi
ok "brew bundle complete";

bot "installing go tools"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
mkdir -p $GOPATH/src $GOPATH/pkg $GOPATH/bin
go get -u github.com/derekparker/delve/cmd/dlv
ok

# do some ruby specific stuff
RUBY_VERSION=2.5.3
echo "🦄  ruby" $RUBY_VERSION
running "rbenv install ruby:$RUBY_VERSION"
rbenv install -s $RUBY_VERSION
rbenv global $RUBY_VERSION
ok rbenv

running "npm settings"
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
ok npm-settings

running "downloading oh-my-zsh"
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
ok oh-my-zsh

running "downloading Meslo Font"
wget --quiet https://raw.githubusercontent.com/powerline/fonts/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf -P ~/Downloads/
ok "Meslo Font"

running "downloading Argonaut.itermcolors"
wget --quiet https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Argonaut.itermcolors -P ~/Downloads/
wget --quiet https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/terminal/Argonaut.terminal -P ~/Downloads/
ok "Argonaut.itermcolors"

bot "installing nano syntax highlighting"
git clone https://github.com/scopatz/nanorc.git ~/.nano
cat ~/.nano/nanorc >> ~/.nanorc
ok

# hard link .zshrc
running "linking your .zshrc!"
ln ~/.dotfiles/.zshrc ~/.zshrc
ok

# hard link .gitconfig
running "linking .gitconfig"
ln ~/.dotfiles/.gitconfig ~/.gitconfig
ok

# hard link .gitignore
running "linking .gitignore"
ln ~/.dotfiles/.gitignore ~/.gitignore
ok

# setup git credentials
yes_or_no "Would you like to set your git credentials now?"
if confirmed; then
  set_git_info
else
  bot "ok, but remember to do it before your first commit! "
fi


bot "setting zsh as the user shell"
CURRENTSHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
if [[ "$CURRENTSHELL" != "/usr/local/bin/zsh" ]]; then
  bot "setting newer homebrew zsh (/usr/local/bin/zsh) as your shell (password required)"
  sudo dscl . -change /Users/$USER UserShell $SHELL /usr/local/bin/zsh > /dev/null 2>&1
  ok
fi

bot "installing visual-studio-code extensions"
for extension in "PKief.material-icon-theme" "zhuangtongfa.Material-theme" "ms-vscode.go" "peterjausovec.vscode-docker"; do
	code --install-extension "${extension}"
done
ok

running "sourcing zshrc"
source ~/.zshrc
ok
SSH_Keygen
bot "Setup complete";
