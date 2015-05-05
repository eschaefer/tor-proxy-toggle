# Tor Proxy Toggle

Toggles a Tor SOCKS proxy for OSX Yosemite from the commandline.

Configured to route traffic through a US-based exit node on the Tor network.

It will help bypassing certain firewalls or regional censorship. **Not** intended for anonymity. OSX leaks all kinds of stuff that won't funnel through this proxy.

## Installation
Download the zip file [from here](https://github.com/eschaefer/tor-proxy-toggle/archive/master.zip), or the Download button to the right.

Unzip, and:

```
$ cd tor-proxy-toggle/
$ bash install.sh
```

### Notes
- OSX might prompt you to install command line developer tools... follow those prompts.
- Also, Homebrew may require `sudo` permissions and prompt you for your password.

### Usage

After installation you will have a commandline alias to toggle your system SOCKS proxy on/off, with traffic routed through Tor:

```
$ torprox
```

Check your new IP address from [whatismyipaddress.com](http://whatismyipaddress.com) or something like that.
