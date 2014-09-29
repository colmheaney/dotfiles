#!/usr/bin/env bash

# Welcome to the Voxbit laptop script! Be prepared to turn your laptop
# into an awesome development machine.

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT
set -e

# Find the tty so we can prompt for confirmation even if we're being piped from curl.
TTY="/dev/$( ps -p$$ -o tty | tail -1 | awk '{print$1}' )"
USER=`whoami`

fancy_echo() {
  printf "\n%b\n" "$1"
}



##  Fail fast if we're not on OS X >= 10.6.0.

if [ "$(uname -s)" != "Darwin" ]; then
  echo "Sorry, script requires Mac OS X to run." >&2
  exit 1
elif [ "$(expr "$(sw_vers -productVersion | cut -f 2 -d .)" \>= 6)" = 0 ]; then
  echo "Script requires Mac OS X 10.6 or later." >&2
  exit 1
fi



echo "

 _|      _|                      _|        _|    _|
 _|      _|    _|_|    _|    _|  _|_|_|        _|_|_|_|
 _|      _|  _|    _|    _|_|    _|    _|  _|    _|
   _|  _|    _|    _|  _|    _|  _|    _|  _|    _|
     _|        _|_|    _|    _|  _|_|_|    _|      _|_|

"
read -p "Welcome to the Voxbit laptop script! Continue [y/n] " ANSWER < $TTY
[[ $ANSWER == "y" ]] || exit 1


# SSH Settings



# Install basic desktop apps
fancy_echo "Installing Chrome browser ..."
#  curl -k -O http://setup.voxbit.io/pkgs/chrome.tar.gz | \
#    tar -xvzf -C /Applications/
fancy_echo "Installing A Better Renamer ..."
#  curl -k -O http://setup.voxbit.io/pkgs/renamer.tar.gz | \
#    tar -xvzf -C /Applications/
#  curl -k -O http://setup.voxbit.io/pkgs/renamer_support.tar.gz | \
#    tar -xvzf -C ~/Library/Application\ Support/
fancy_echo "Installing Alfred ..."
#  curl -k -O http://setup.voxbit.io/pkgs/alfred.tar.gz | \
#    tar -xvzf -C /Applications/
#  curl -k -O http://setup.voxbit.io/pkgs/alfred_support.tar.gz | \
#    tar -xvzf -C ~/Library/Application\ Support/
fancy_echo "Installing Office 2011 ..."
#  curl -k -O http://setup.voxbit.io/pkgs/office.tar.gz | \
#    tar -xvzf -C /Applications/
#  curl -k -O http://setup.voxbit.io/pkgs/office_support.tar.gz | \
#    tar -xvzf -C ~/Library/Application\ Support/
fancy_echo "Installing Sequel Pro ..."
#  curl -k -O http://setup.voxbit.io/pkgs/sequel.tar.gz | \
#    tar -xvzf -C /Applications/
fancy_echo "Installing Sip colour picker ..."
#  curl -k -O http://setup.voxbit.io/pkgs/sip.tar.gz | \
#    tar -xvzf -C /Applications/
fancy_echo "Installing Sublime Text ..."
#  curl -k -O http://setup.voxbit.io/pkgs/sublime.tar.gz | \
#    tar -xvzf -C /Applications/
#  curl -k -O http://setup.voxbit.io/pkgs/sublime_support.tar.gz | \
#    tar -xvzf -C ~/Library/Application\ Support/
fancy_echo "Installing Virtualbox ..."
#  curl -k -O http://setup.voxbit.io/pkgs/virtualbox.tar.gz
fancy_echo "Installing Vagrant ..."
#  curl -k -O http://setup.voxbit.io/pkgs/vagrant.tar.gz

fancy_echo "Installing Xcode Tools ..."
  xcode-select --install


# Set OSX up with sane defaults
fancy_echo "Making OS X nicer ..."
  chflags nohidden ~/Library

  defaults write com.apple.finder ShowStatusBar -bool false
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  defaults write com.apple.frameworks.diskimages skip-verify -bool true
  defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
  defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
  defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
  defaults write com.apple.DiskUtility advanced-image-options -bool true

  defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes -bool true
  defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
  sudo tmutil disablelocal

# General Hacks
  defaults write com.apple.screencapture disable-shadow -bool true
  defaults write com.apple.screencapture type -string "png"

  defaults write com.apple.dock orientation -string "bottom"
  defaults write com.apple.dock pinning -string "center"
  defaults write com.apple.dock tilesize -int 24
  defaults write com.apple.dock size-immutable -bool false
  defaults write com.apple.dock largesize -int 48
  defaults write com.apple.dock contents-immutable -bool false
  defaults write com.apple.Dock showhidden -bool true

  defaults write com.apple.finder AnimateInfoPanes -bool true
  defaults write com.apple.finder QLEnableTextSelection -bool true
  defaults write com.apple.finder QLHidePanelOnDeactivate -bool false

  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

  killall Finder
  killall Dock

# App options
  defaults write com.google.Chrome ExtensionInstallSources -array \
              "https://*.github.com/*" "http://userscripts.org/*"
  defaults write com.google.Chrome.canary ExtensionInstallSources -array \
              "https://*.github.com/*" "http://userscripts.org/*"
  defaults write com.apple.Safari IncludeDebugMenu -bool true



## Install environment resources
if ! command -v brew &>/dev/null; then
  fancy_echo "Installing Homebrew, a good OS X package manager ..."
    ruby <(curl -fsS https://raw.github.com/Homebrew/homebrew/go/install)

  if ! grep -qs "recommended by brew doctor" ~/.profile; then
    fancy_echo "Put Homebrew location earlier in PATH ..."
      printf '\n# recommended by brew doctor\n' >> ~/.profile
      printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.profile
      export PATH="/usr/local/bin:$PATH"
  fi
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi


fancy_echo "Updating Homebrew formulas ..."
  brew update
  brew tap homebrew/dupes
  brew tap homebrew/completions

fancy_echo "Installing gcc-4.2 like a good boy/girl ..."
  brew install apple-gcc42
  sudo mv /usr/bin/gcc /usr/bin/gcc-clang
  sudo ln -s /usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/gcc-4.2 /usr/bin/gcc

fancy_echo "Installing The Silver Searcher (better than ack or grep) to search the contents of files ..."
  brew install the_silver_searcher

fancy_echo "Installing vim from Homebrew to get the latest version ..."
  brew install vim

fancy_echo "Installing wget from Homebrew because years of habit is hard to break ..."
  brew install wget

fancy_echo "Installing ctags, to index files for vim tab completion of methods, classes, variables ..."
  brew install ctags
  # Unfuck brew's ctags path
  sudo grep '/usr/local/bin' /etc/paths; sudo grep -v '/usr/local/bin' /etc/paths

fancy_echo "Installing tmux, to save project state and switch between projects ..."
  brew install tmux

fancy_echo "Installing reattach-to-user-namespace, for copy-paste and RubyMotion compatibility with tmux ..."
  brew install reattach-to-user-namespace

fancy_echo "Installing ImageMagick, to crop and resize images ..."
  brew install imagemagick

fancy_echo "Installing QT, used by Capybara Webkit for headless Javascript integration testing ..."
  brew install qt

fancy_echo "Installing watch, to execute a program periodically and show the output ..."
  brew install watch


fancy_echo "Installing rbenv, to change Ruby versions ..."
  brew install rbenv

  if ! grep -qs "rbenv init" ~/.profile; then
    printf 'export PATH="$HOME/.rbenv/bin:$PATH"\n' >> ~/.profile
    printf 'eval "$(rbenv init - --no-rehash)"\n' >> ~/.profile

    fancy_echo "Enable shims and autocompletion ..."
      eval "$(rbenv init -)"
  fi
  export PATH="$HOME/.rbenv/bin:$PATH"

fancy_echo "Installing rbenv-gem-rehash so the shell automatically picks up binaries after installing gems with binaries..."
  brew install rbenv-gem-rehash

fancy_echo "Installing ruby-build, to install Rubies ..."
  brew install ruby-build

fancy_echo "Installing rbenv-bundler, to make shims bundler aware ..."
  brew install rbenv-bundler

fancy_echo "Installing rbenv-binstubs, making bundler nicer ..."
  brew install rbenv-binstubs

fancy_echo "Installing rbenv-gemset, just like rvm ..."
  brew install rbenv-gemset

fancy_echo "Installing rbenv-use, because patchsets are a pain to type ..."
  brew install rbenv-use

fancy_echo "Installing rbenv-default-gems ..."
  brew install rbenv-default-gems

fancy_echo "Install rbenv-readline ..."
  brew install rbenv-readline


fancy_echo "Upgrading and linking OpenSSL ..."
  brew install openssl
  brew link openssl --force


ruby_version="$(curl -sSL http://ruby.thoughtbot.com/latest)"

#fancy_echo "Installing Ruby $ruby_version ..."
#  if [ "$ruby_version" = "2.1.1" ]; then
#    curl -fsSL https://gist.github.com/mislav/a18b9d7f0dc5b9efc162.txt | rbenv install --patch 2.1.1
#  else
#    rbenv install "$ruby_version"
#  fi

fancy_echo "Setting $ruby_version as global default Ruby ..."
  rbenv global "$ruby_version"
  rbenv rehash

fancy_echo "Updating to latest Rubygems version ..."
  gem update --system

fancy_echo "Installing Bundler to install project-specific Ruby gems ..."
  gem install bundler --no-document --pre

fancy_echo "Configuring Bundler for faster, parallel gem installation ..."
  number_of_cores=$(sysctl -n hw.ncpu)
  bundle config --global jobs $((number_of_cores - 1))


## Install network stuff
fancy_echo "Installing xcode tools ..."

fancy_echo "Installing mtr package ..."
  brew install mtr

fancy_echo "Installing nmap package ..."
  brew install nmap

fancy_echo "Installing pgrep package ..."
  brew install pgrep

fancy_echo "Installing lesspipe package ..."
  brew install lesspipe --syntax-highlighting

fancy_echo "Installing spark package ..."
  brew install spark

fancy_echo "Installing completions ..."
  brew install bash-completion vagrant-completion rails-completion \
    rake-completion bundler-completion gem-completion ruby-completion
  printf 'if [ -f `brew --prefix`/etc/bash_completion ]; then' >> ~/.profile
  printf ' . `brew --prefix`/etc/bash_completion' >> ~/.profile
  printf 'fi' >> ~/.profile

fancy_echo "Installing powder & Pow ..."
  gem install powder
  powder install


##  Install Golang
fancy_echo "Installing golang goodness ..."
  brew install go

##  Configure Git etc
fancy_echo "Installing git package ..."
  brew install git \
        --with-blk-sha1 \
        --with-gettext \
        --with-pcre \
        --with-persistent-https
  brew install git-multipush

fancy_echo "Configuring SSH keys ..."
  git config --global user.name "$1"
  git config --global user.email "$USER@voxbit.net"
  git config --global credential.helper osxkeychain

  mkdir -p ~/.gitrc
  printf '[core]\n  excludesfile = ~/.gitrc/ignore\n  autocrlf = input\n' >> ~/.gitconfig
#  curl -k -O http://setup.voxbit.io/pkgs/gitignore | cat > ~/.gitrc/ignore
  printf '[color]\n  ui = auto\n' >> ~/.gitconfig
  printf '[push]\n default = current\n' >> ~/.gitconfig
  printf '[fetch]\n  prune = true\n' >> ~/.gitconfig
  printf '[commit]\n  template = ~/.gitrc/message\n' >> ~/.gitconfig
  printf '[mergetool]\n  keepBackup = true\n' >> ~/.gitconfig


## Install OS X Packages
fancy_echo " ... Linking Sublime Text 3 ..."
  if [[ -f != ~/.bin/subl ]]l then
    ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/.bin/subl
  fi

