# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

setxkbmap -option -option ctrl:swapcaps us

# Map (in order):
# - caps lock key to control
# - left ctrl key to Mode_switch
# - Semicolon key to support ae with Mode_switch
# - Apostrophe key to support oslash with Mode_switch
# - Bracketleft key to support aring with Mode_switch
xmodmap -e "keycode 66 = Control_L NoSymbol Control_L" \
        -e "keycode 37 = Mode_switch NoSymbol Mode_switch" \
        -e "keycode 47 = semicolon colon ae AE" \
        -e "keycode 48 = apostrophe quotedbl oslash Oslash" \
        -e "keycode 34 = bracketleft braceleft aring Aring"
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
