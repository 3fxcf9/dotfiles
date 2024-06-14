{
  inputs,
  config,
  pkgs,
  ...
}: let
  lowBatteryNotifier =
    pkgs.writeScript "lowBatteryNotifier"
    ''
      BAT_PCT=`${pkgs.acpi}/bin/acpi -b | ${pkgs.gnugrep}/bin/grep -P -o '[0-9]+(?=%)' | tail -n 1`
      BAT_STA=`${pkgs.acpi}/bin/acpi -b | ${pkgs.gnugrep}/bin/grep -P -o '\w+(?=,)' | tail -n 1`
      echo "`date` battery status:$BAT_STA percentage:$BAT_PCT"
      test $BAT_PCT -le 78 && test $BAT_PCT -gt 5 && test $BAT_STA = "Discharging" && DISPLAY=:0.0 ${pkgs.libnotify}/bin/notify-send -c device -u normal   "Low Battery" "Would be wise to keep my charger nearby."
      test $BAT_PCT -le  5                        && test $BAT_STA = "Discharging" && DISPLAY=:0.0 ${pkgs.libnotify}/bin/notify-send -c device -u critical "Low Battery" "Charge me or watch me die!"
    '';
in {
  # ENV
  environment = {
    variables = {EDITOR = "nvim";};
    sessionVariables = {
      # Hint Electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };

    shells = with pkgs; [zsh];
    pathsToLink = ["/share/zsh"];
  };

  # Keyboard
  services.xserver.xkb.layout = "fr";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  # List services that you want to enable:
  services = {
    # OpenSSH daemon
    openssh.enable = true;

    dbus.enable = true;

    # Low battery warning
    acpid = {
      enable = true;
    };
    cron = {
      enable = true;
      systemCronJobs = let
        userName = "moi";
      in [
        "* * * * * ${userName} bash -x ${lowBatteryNotifier} > /tmp/cron.batt.log 2>&1"
      ];
    };

    # Sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Syncthing
    #syncthing = {
    #  enable = true;
    #  user = "josiah";
    #  group = "users";
    #  dataDir = "/home/moi";
    #  configDir = "/home/moi/.config/syncthing";
    #  guiAddress = "127.0.0.1:8384";
    #  openDefaultPorts = true;
    #};
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.utf8";
    LC_IDENTIFICATION = "fr_FR.utf8";
    LC_MEASUREMENT = "fr_FR.utf8";
    LC_MONETARY = "fr_FR.utf8";
    LC_NAME = "fr_FR.utf8";
    LC_NUMERIC = "fr_FR.utf8";
    LC_PAPER = "fr_FR.utf8";
    LC_TELEPHONE = "fr_FR.utf8";
    LC_TIME = "fr_FR.utf8";
  };

  users.users.moi = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [];
  };

  # Polkit
  security.polkit.enable = true;

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound with pipewire
  sound.enable = true;
  security.rtkit.enable = true;

  # Enable Docker
  virtualisation.docker.enable = true;

  # Add additional man pages
  documentation.dev.enable = true;

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
