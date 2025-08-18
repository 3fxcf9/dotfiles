# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=10000
setopt extendedglob notify
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/moi/.zshrc'

autoload -Uz compinit
compinit

# Pulsarship
export PULSARSHIP_CONFIG="$HOME/.config/pulsarship/pulsarship.toml"
eval "$(pulsarship init zsh)"

# Fix password prompt
# export GPG_TTY=$(tty)
# export SSH_ASKPASS=

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
fi
