# Tor Proxy Toggle

Gives you a `torprox` command to toggle a Tor SOCKS proxy for OSX Yosemite.

Your web browser will then be able to run much of its traffic through Tor.

It will help bypassing certain firewalls or regional censorship. **Not** intended for anonymity. OSX leaks all kinds of stuff that won't funnel through this proxy.

Configured to route traffic through a US-based exit node on the Tor network.

## Installation
Download the zip file [from here](https://github.com/eschaefer/tor-proxy-toggle/archive/master.zip), or the Download button to the right.

Unzip, and:

```
$ cd tor-proxy-toggle/
$ bash install.sh
```

**After installation, if `torprox` doesn't become available in the same window, open a new terminal window and try it there.**

### Notes
- OSX might prompt you to install command line developer tools... follow those prompts.
- Also, Homebrew may require `sudo` permissions and prompt you for your password.
- The proxy toggle script will execute `networksetup -setsocksfirewallproxy`, which apparently requires sudo permissions.
- There are probably installation issues for all kinds of edge cases that I didn't think of. Feel free to contribute a pull request, or [file an issue](https://github.com/eschaefer/tor-proxy-toggle/issues)

### Usage

After installation you will have a commandline alias to toggle your system SOCKS proxy on/off, with traffic routed through Tor:

```
$ torprox
```

Check your new IP address from [whatismyipaddress.com](http://whatismyipaddress.com) or something like that.

### TODO:
- Support older versions of OSX (`networksetup` has different syntax, params, etc)
- Add option to select preferred country as exit node.
- Refactor, DRY
- Better fail messages
