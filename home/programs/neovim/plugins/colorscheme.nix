{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
    ];
    extraLuaConfig =
      /*
      lua
      */
      ''
        local transparent = false -- set to true if you would like to enable transparency

        local bg = "#050518"
        local bg_dark = "#11111b"
        local bg_highlight = "#181825"
        local bg_search = "#b56334"
        local bg_visual = "#313244"
        local fg = "#CBE0F0"
        local fg_dark = "#B4D0E9"
        local fg_gutter = "#627E97"
        local border = "#547998"

        require("tokyonight").setup({
          style = "night",
          transparent = transparent,
          styles = {
            sidebars = transparent and "transparent" or "dark",
            floats = transparent and "transparent" or "dark",
          },
          on_colors = function(colors)
            colors.bg = bg
            colors.bg_dark = transparent and colors.none or bg_dark
            colors.bg_float = transparent and colors.none or bg_dark
            colors.bg_highlight = bg_highlight
            colors.bg_popup = bg_dark
            colors.bg_search = bg_search
            colors.bg_sidebar = transparent and colors.none or bg_dark
            colors.bg_statusline = transparent and colors.none or bg_dark
            colors.bg_visual = bg_visual
            colors.border = border
            colors.fg = fg
            colors.fg_dark = fg_dark
            colors.fg_float = fg
            colors.fg_gutter = fg_gutter
            colors.fg_sidebar = fg_dark
          end,
        })

        vim.cmd("colorscheme tokyonight")
        vim.cmd("highlight NvimTreeNormal guibg=#050518")
        vim.cmd("highlight NvimTreeNormalNC guibg=#050518")
        vim.cmd("highlight NvimTreeNormalFloat guibg=#050518")
        vim.cmd("highlight NvimTreeWinSeparator guibg=#050518")

      '';
  };
}
