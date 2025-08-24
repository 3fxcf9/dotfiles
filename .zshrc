setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
setopt extendedglob        # enable extended globbing
unsetopt autocd beep       # disable terminal beeps

PROMPT_EOL_MARK="" # hide EOL sign ('%')


# Keybindings
bindkey -e
bindkey ' ' magic-space           # do history expansion on space
bindkey '^[[1;5C' forward-word    # ctrl + ->
bindkey '^[[1;5D' backward-word   # ctrl + <-
bindkey '^[[3~' delete-char       # delete
bindkey '^H' backward-kill-word   # ctrl + delete
bindkey '5~' kill-word            # ctrl + backspace

# enable completion features
autoload -Uz compinit
compinit
zstyle :compinstall filename '/home/moi/.zshrc'

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name \'\'
zstyle ':completion:*' list-colors \'\'
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=100000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

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

# GTK theme
export GTK_THEME=Adwaita:dark

# Editor
export EDITOR=nvim

# User binaries
export PATH="$HOME/.local/bin:$PATH"

############## - ALIAS - #############

mkcd () {
      mkdir -p "$1" && cd "$1"
}

alias nd="cd ~/dotfiles"
alias ne="nvim ~/dotfiles"
alias st="(cd ~/dotfiles && stow .)"
alias nml="nmcli device wifi rescan && nmcli device wifi list"
alias nmc="nmcli device wifi connect"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ll="eza --color=always --long"
alias udm="udisksctl mount -b"
alias udum="udisksctl unmount -b"

# Fzf
source <(fzf --zsh)

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Opam
[[ ! -r ~/.opam/opam-init/init.zsh ]] || source ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null

# Zsh extensions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
