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
      "15121c"
      "cb5760"
      "999f63"
      "d4a067"
      "6c90a8"
      "776690"
      "528a9b"
      "eeffff"
      "727480"
      "cb5760"
      "999f63"
      "d4a067"
      "6c90a8"
      "776690"
      "528a9b"
      "eeffff"
    ];
  };

  environment.etc."issue".text = ''
    [1;32m>>> Welcome to \n <<<[0m

    [1;33mNixOS \m - \l - \U connected[0m

    [1;30m\d \t[0m

  '';

  console.keyMap = config.var.keyboardLayout;
}
