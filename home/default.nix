{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    #inputs.hyprland.homeManagerModules.default
    ./apps
    ./config
  ];

  home.username = "moi";
  home.homeDirectory = "/home/moi";

  home.stateVersion = "23.05";

  home.keyboard = null;

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # List of user programs
  home.packages = with pkgs; [
    alacritty
    firefox
    pavucontrol
    jq
    signal-desktop
    eza
    tldr
    glow
    zathura
    libreoffice-qt
    python3
    texlive.combined.scheme-full
    vscode-fhs
    pulseaudio
    gimp
    wl-clipboard
    imv
  ];

  programs.git = {
    enable = true;
    userName = "3fxcf9";
    userEmail = "123954477+3fxcf9@users.noreply.github.com";
    extraConfig.init.defaultBranch = "main";
  };

  nixpkgs.overlays = [
    # Make Signal desktop display
    (self: super: {
      signal-desktop = super.signal-desktop.overrideAttrs (old: {
        preFixup =
          old.preFixup
          + ''
            gappsWrapperArgs+=(
              --add-flags "--enable-features=UseOzonePlatform"
              --add-flags "--ozone-platform=wayland"
            )
          '';
      });
    })
  ];

  # GTK
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaPink;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 40;
    gtk.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {color-scheme = "prefer-dark";};
  };

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };

    font = {
      name = "Monaspace Neon";
      size = 10;
    };

    cursorTheme = {
      name = "Catppuccin-Mocha-Dark";
      package = pkgs.catppuccin-cursors.mochaDark;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
               gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name=Catppuccing-Mocha-Dark
      '';
    };
  };

  home.sessionVariables.GTK_THEME = "Adwaita-dark";

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
