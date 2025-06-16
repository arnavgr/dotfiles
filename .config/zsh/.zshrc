# benchmarking zsh
#zmodload zsh/zprof

# Check if catnip is installed
if command -v catnip &> /dev/null; then
    catnip
# Check if fastfetch is installed
elif command -v fastfetch &> /dev/null; then
    fastfetch
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#startup programs
eval $(thefuck --alias)
autoload -U compinit; compinit

# history management
HISTSIZE=5000
HISTFILE=~/.config/zsh/.zsh_history
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# using plugin manager antidote
source ~/.config/zsh/.antidot/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

# enables history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# vim bindings
# bindkey -v

# custom prompt design
# PROMPT='%F{green}%~%f %F{blue}->%f '

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
