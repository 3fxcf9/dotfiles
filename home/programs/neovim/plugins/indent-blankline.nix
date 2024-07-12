{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      indent-blankline-nvim
    ];
    extraLuaConfig =
      /*
      lua
      */
      ''
        require("ibl").setup {
            indent = { highlight = highlight, char = "┊" },
        }
      '';
  };
}
