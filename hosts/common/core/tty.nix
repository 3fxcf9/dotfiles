{
  pkgs,
  config,
  ...
}: {
  console = {
    earlySetup = true;
    packages = with pkgs; [terminus_font];
    font = "ter-118b";
    colors = [
      "15161e"
      "f7768e"
      "9ece6a"
      "e0af68"
      "7aa2f7"
      "bb9af7"
      "7dcfff"
      "a9b1d6"

      "414868"
      "f7768e"
      "9ece6a"
      "e0af68"
      "7aa2f7"
      "bb9af7"
      "7dcfff"
      "c0caf5"

      # "15121c"
      # "cb5760"
      # "999f63"
      # "d4a067"
      # "6c90a8"
      # "776690"
      # "528a9b"
      # "eeffff"
      # "727480"
      # "cb5760"
      # "999f63"
      # "d4a067"
      # "6c90a8"
      # "776690"
      # "528a9b"
      # "eeffff"
    ];
  };

  environment.etc."issue".text = ''
    [1;32m>>> Welcome to \n <<<[0m

    [1;33mNixOS \m - \l - \U connected[0m

    [1;30m\d \t[0m

  '';

  console.keyMap = config.var.keyboardLayout;
}
