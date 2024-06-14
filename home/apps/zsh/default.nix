{pkgs, ...}: {
  home.packages = with pkgs; [fd bat];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--bind=ctrl-r:down"
    ];
  };
  home.sessionVariables.FZF_DEFAULT_OPTS = "--bind=ctrl-r:down";

  programs.starship = {enable = true;};

  # ZSH
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      nb = "sudo nixos-rebuild switch --flake ~/dotfiles#";
      nml = "nmcli device wifi rescan && nmcli device wifi list";
      nmc = "nmcli device wifi connect";
      ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
    };

    history.size = 10000;

    initExtra = ''
      # Zsh option
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
      #zstyle :compinstall filename '/home/kali/.zshrc'
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
      setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
      setopt hist_ignore_dups       # ignore duplicated commands history list
      setopt hist_ignore_space      # ignore commands that start with space
      setopt hist_verify            # show command with history expansion to user before running it
      setopt share_history         # share command history data

      # force zsh to show the complete history
      alias history="history 0"

      # configure `time` format
      TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

      # Starship prompt
      eval "$(starship init zsh)"

      # -- Use fd instead of fzf --
      export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

      # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
      # - The first argument to the function ($1) is the base path to start traversal
      # - See the source code (completion.{bash,zsh}) for the details.
      _fzf_compgen_path() {
        fd --hidden --exclude .git . "$1"
      }

      # Use fd to generate the list for directory completion
      _fzf_compgen_dir() {
        fd --type=d --hidden --exclude .git . "$1"
      }

      show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

      export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
      export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

      # Advanced customization of fzf options via _fzf_comprun function
      # - The first argument to the function is the name of the command.
      # - You should make sure to pass the rest of the arguments to fzf.
      _fzf_comprun() {
        local command=$1
        shift

        case "$command" in
          cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
          export|unset) fzf --preview "eval 'echo \$\{\}'"         "$@" ;;
          ssh)          fzf --preview 'dig {}'                   "$@" ;;
          *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
        esac
      }
    '';
  };
}
