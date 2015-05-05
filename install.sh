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
LOCAL_TORRC="/usr/local/etc/tor/torrc"
curl -fsSL https://raw.githubusercontent.com/eschaefer/tor-proxy-toggle/master/bin/torrc -o $LOCAL_TORRC

# load tor
mkdir -p ~/Library/LaunchAgents
ln -sfv /usr/local/opt/tor/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.tor.plist

mkdir $HOME/Scripts/

LOCAL_PROXTOGGLE="$HOME/Scripts/tor-proxy-toggle.sh"
curl -fsSL https://raw.githubusercontent.com/eschaefer/tor-proxy-toggle/master/bin/tor-proxy-toggle.sh -o $LOCAL_PROXTOGGLE

ZSH="$HOME/.zshrc"
BASHPROFILE="$HOME/.bash_profile"
if [ -f "$ZSH" ]; then
  if [ grep -q torprox "$ZSH" ]; then
    echo "zhrc file already has a torprox alias"
  else
    echo '# tor proxy' >> $ZSH
    echo 'alias torprox="bash $HOME/Scripts/tor-proxy-toggle.sh"' >> $ZSH
    source $ZSH
  fi
elif [ -f "$BASHPROFILE" ]; then
  if [ grep -q torprox "$BASHPROFILE" ]; then
    echo "bash_profile file already has a torprox alias"
  else
   echo '# tor proxy' >> $BASHPROFILE
   echo 'alias torprox="bash $HOME/Scripts/tor-proxy-toggle.sh"' >> $BASHPROFILE
   source $BASHPROFILE
  fi
else
  echo "No zsh or bash profile found... setting one up..."
  touch $HOME/.bash_profile
  echo 'alias torprox="bash $HOME/Scripts/tor-proxy-toggle.sh"' >> $BASHPROFILE
  source $BASHPROFILE
fi

# try toggling the tor proxy
# can see the result of this in Network preferences > Proxies > SOCKS proxy
# or test your new IP address: http://whatismyipaddress.com
source $BASHPROFILE
