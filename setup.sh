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
    running "updating to most recent brew version"
    brew doctor
    brew update
    ok
fi

running "Running brew bundle...";
brew bundle;
if [[ $? != 0 ]]; then
        error "brew bundle could not complete"
        exit 2
fi
ok "brew bundle complete";

# do some ruby specific stuff
RUBY_VERSION=2.5.3
echo "🦄  ruby" $RUBY_VERSION
running rbenv install -s $RUBY_VERSION
rbenv install -s $RUBY_VERSION
rbenv global $RUBY_VERSION
ok rbenv

running "downloading oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
if [[ $? != 0 ]]; then
  error "unable to install oh-my-zsh -> quitting setup"
  exit 2
fi
ok oh-my-zsh

running "downloading Meslo Font"
wget https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf -P ~/
ok "Meslo Font"


# hard link .zshrc
running "linking your .zshrc!"
ln ~/.dotfiles/.zshrc ~/.zshrc
ok

# hard link .gitconfig
running "linking .gitconfig"
ln ~/.dotfiles/.gitconfig ~/.gitconfig
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

for extension in "PKief.material-icon-theme" "zhuangtongfa.Material-theme"; do
	code --install-extension "${extension}"
done

running "sourcing zshrc"
source ~/.zshrc
ok
bot "Setup complete";
