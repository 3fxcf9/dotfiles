{config, ...}: {
  imports = [./variables-config.nix];

  config.var = {
    hostname = "beta";
    username = "moi";
    homeDirectory = "/home/" + config.var.username;
    configDirectory = config.var.homeDirectory + "/dotfiles";

    keyboardLayout = "fr";
    keyboardLayoutVariant = "ergol";

    timeZone = "Europe/Paris";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "fr_FR.UTF-8";

    git = {
      username = "3fxcf9";
      email = "123954477+3fxcf9@users.noreply.github.com";
    };

    stateVersion = "24.05";

    autoUpgrade = false;
    autoGarbageCollector = false;
    # change the sops configuration if you want to enable that:
    sops = true;
    theme = import ../../themes/main.nix;
  };
}
