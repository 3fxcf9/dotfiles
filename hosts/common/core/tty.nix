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
      config.var.theme.colors.c0
      config.var.theme.colors.c1
      config.var.theme.colors.c2
      config.var.theme.colors.c3
      config.var.theme.colors.c4
      config.var.theme.colors.c5
      config.var.theme.colors.c6
      config.var.theme.colors.c7

      config.var.theme.colors.c8
      config.var.theme.colors.c9
      config.var.theme.colors.c10
      config.var.theme.colors.c11
      config.var.theme.colors.c12
      config.var.theme.colors.c13
      config.var.theme.colors.c14
      config.var.theme.colors.c15
    ];
  };

  environment.etc."issue".text = ''
    [1;32m>>> Welcome to \n <<<[0m

    [1;33mNixOS \m - \l - \U connected[0m

    [1;30m\d \t[0m

  '';

  console.keyMap = config.var.keyboardLayout;
}
