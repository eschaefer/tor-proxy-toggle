#!/bin/bash

echo "Setting up Homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# OSX might prompt you to install command line developer tools... follow prompts
# Also, Homebrew may require sudo permissions and prompt for password.

echo "Updating Homebrew..."
brew update

echo "Installing Tor..."
brew install tor

echo "Configuring Tor to prefer US-based exit nodes..."
# post contents of torrc on github
# curl file contents
# write contents to /usr/local/etc/tor/torrc
LOCAL_TORRC="/usr/local/etc/tor/torrc"
REMOTE_TORRC="$(curl -fsSL https://raw.githubusercontent.com/eschaefer/tor-proxy-toggle/master/bin/torrc)"
touch $LOCAL_TORRC
echo $REMOTE_TORRC >> $LOCAL_TORRC

# load tor
launchctl load $HOME/Library/LaunchAgents/homebrew.mxcl.tor.plist

# post contents of torprox.sh on github
# curl file contents
# write contents to $HOME/Scripts/tor-proxy-toggle.sh
mkdir $HOME/Scripts/

LOCAL_PROXTOGGLE="$HOME/Scripts/tor-proxy-toggle.sh"
REMOTE_PROXTOGGLE="$(curl -fsSL https://raw.githubusercontent.com/eschaefer/tor-proxy-toggle/master/bin/tor-proxy-toggle.sh)"
touch $LOCAL_PROXTOGGLE
echo $REMOTE_PROXTOGGLE >> $LOCAL_PROXTOGGLE

ZSH="$HOME/.zshrc"
BASHPROFILE="$HOME/.bash_profile"
if [ -f "$ZSH" ]; then
  echo '# tor proxy' >> $ZSH
  echo 'alias torprox="bash $HOME/Scripts/tor-proxy-toggle.sh"' >> $ZSH
  source $ZSH
elif [ -f "$BASHPROFILE" ]; then
  echo '# tor proxy' >> $BASHPROFILE
  echo 'alias torprox="bash $HOME/Scripts/tor-proxy-toggle.sh"' >> $BASHPROFILE
  source $BASHPROFILE
else
  echo "No zsh or bash profile found."
fi

# try toggling the tor proxy
# can see the result of this in Network preferences > Proxies > SOCKS proxy
torprox
