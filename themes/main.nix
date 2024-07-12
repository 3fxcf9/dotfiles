{
  wallpaper = "main.jpg";

  font = "Monaspace Neon";
  font-mono = "Monaspace Neon";
  font-size = 13;

  rounding = 4;
  gaps-in = 4;
  gaps-out = 4 * 2;
  border-size = 1;
  fetch = "nerdfetch"; # "nerdfetch" | "neofetch" | "pfetch" | "none"

  waybar = {
    transparent = true; # FIXME: Make it work
    position = "top"; # FIXME: Remove top margin
    font-size = 13;
  };

  colors = {
    c0 = "1e1e2e"; # black
    c1 = "f38ba8"; # red
    c2 = "a6e3a1"; # green
    c3 = "fab387"; # yellow
    c4 = "89b4fa"; # blue
    c5 = "A594FD"; # magenta
    c6 = "74c7ec"; # cyan
    c7 = "cdd6f4"; # white
    c8 = "313244"; # bright black
    c9 = "eba0ac"; # bright red
    c10 = "94e2d5"; # bright green
    c11 = "f9e2af"; # bright yellow
    c12 = "b4befe"; # bright blue
    c13 = "f5c2e7"; # bright magenta
    c14 = "94e2d5"; # bright cyan
    c15 = "bac2de"; # bright white

    bg = "050518";
    fg = "EAF0F5";
    fgdark = "333343";

    accent = "b4befe";
    accentFg = "0B0B0B";

    # Should make those automtic
    accentName = "magenta";
    accentNumber = "5";
  };
}
