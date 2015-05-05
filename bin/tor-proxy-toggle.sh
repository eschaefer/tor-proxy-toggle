#!/bin/bash

e=$(networksetup -getsocksfirewallproxy wi-fi | grep "No")

if [ -n "$e" ]; then
  echo "Turning on proxy"
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.tor.plist
  sudo networksetup -setsocksfirewallproxy wi-fi 127.0.0.1 9050
  sudo networksetup -setstreamingproxy wi-fi 127.0.0.1 9050
  sudo networksetup -setstreamingproxystate wi-fi on
  sudo networksetup -setsocksfirewallproxystate wi-fi on
else
  echo "Turning off proxy"
  sudo networksetup -setstreamingproxystate wi-fi off
  sudo networksetup -setsocksfirewallproxystate wi-fi off
  launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.tor.plist
fi
