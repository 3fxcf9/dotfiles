{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = "#050518";
          foreground = "#dedede";
        };
        bright = {
          black = "#727480";
          blue = "#6c90a8";
          cyan = "#528a9b";
          green = "#999f63";
          magenta = "#776690";
          red = "#cb5760";
          white = "#eeffff";
          yellow = "#d4a067";
        };
        normal = {
          black = "#15121c";
          blue = "#6c90a8";
          cyan = "#528a9b";
          green = "#999f63";
          magenta = "#776690";
          red = "#cb5760";
          white = "#eeffff";
          yellow = "#d4a067";
        };
      };
      font.size = 10;
      font.normal.family = "Monaspace Neon";
      font.italic.family = "Monaspace Neon";
      font.bold.family = "Monaspace Neon";
      window.opacity = 1;
      window.padding = {
        x = 16;
        y = 8;
      };
    };
  };
}
