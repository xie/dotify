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
cp zsh_files/.* ~/.dotfiles/zsh_files/
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

running "brew install mas"
brew install mas
running "mas signin"
mas signin

running "Running brew bundle...";
brew bundle;
if [[ $? != 0 ]]; then
        error "brew bundle could not complete"
        exit 2
fi
ok "brew bundle complete";

export GOPATH=$HOME
mkdir -p $GOPATH/src $GOPATH/pkg $GOPATH/bin

# setup rbenv & install ruby 
RUBY_VERSION=2.6.3
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

running "installing zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions.git \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
ok

running "installing zsh-history-substring-search"
git clone https://github.com/zsh-users/zsh-history-substring-search \
  ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
ok

running "installing zsh-fast-syntax-highlighting"
git clone https://github.com/zdharma/fast-syntax-highlighting.git \
  ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
ok

running "installing zsh-you-should-use"
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git \
  ~/.oh-my-zsh/custom/plugins/you-should-use
ok

running "installing zsh-plugins-autoupdate"
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins.git \
  ~/.oh-my-zsh/custom/plugins/autoupdate
ok

running "downloading Argonaut.itermcolors"
wget --quiet https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Argonaut.itermcolors -P ~/Downloads/
wget --quiet https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/terminal/Argonaut.terminal -P ~/Downloads/
ok "Argonaut.itermcolors"

bot "installing nano syntax highlighting"
git clone https://github.com/scopatz/nanorc.git ~/.nano
echo "set linenumbers" >> ~/.nanorc
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

bot "setting zsh as the user shell"
CURRENTSHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
if [[ "$CURRENTSHELL" != "/usr/local/bin/zsh" ]]; then
    bot "setting newer homebrew zsh (/usr/local/bin/zsh) as your shell (password required)"
    sudo dscl . -change /Users/$USER UserShell $SHELL /usr/local/bin/zsh > /dev/null 2>&1
    ok
fi

bot "installing visual-studio-code extensions"
code --install-extension "shan.code-settings-sync"
ok

running "sourcing zshrc"
source ~/.zshrc
ok
SSH_Keygen
bot "Setup complete";

bot "Add the following sshkey to Github at https://github.com/settings/ssh/new "
cat ~/.ssh/id_ed25519.pub
