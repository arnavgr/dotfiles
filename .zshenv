# exporting variables
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export EDITOR="nvim"
export VISUAL="nvim"

# adding ~/bin to $PATH
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# startx if tty1
#if [ "$(tty)" = "/dev/tty1" ] ; then
 #   startx
#fi
