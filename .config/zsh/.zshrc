#startup programs
neofetch

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

# autocompletion
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# vim bindings
# bindkey -v

# custom prompt design
# PROMPT='%F{green}%~%f %F{blue}->%f '

# zsh-syntax-highlighting
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autocompletion
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# git-prompt
source ~/.config/zsh/git-prompt/git-prompt.zsh

# aliases
source ~/.config/zsh/.zsh_alias

