return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    local transparent = true
    if vim.g.neovide then
      transparent = false
    end

    local bg = "#181926"
    local bg_dark = "#011423"
    local bg_highlight = "#212330"
    local bg_search = "#f0c874"
    local fg_search = bg_dark
    local bg_visual = "#353f58"
    local fg = "#C1C8D7"
    local fg_dark = "#9ca3b1"
    local fg_gutter = "#414251"
    local border = "#2f304b"

    require("tokyonight").setup({
      style = "night",
      transparent = transparent,
      dim_inactive = true,
      hide_inactive_statusline = true,
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
      on_highlights = function(hl, colors)
        hl.Search = {
          bg = bg_search,
          fg = fg_search,
        }
      end,
    })

    vim.cmd("colorscheme tokyonight")
  end,
}
