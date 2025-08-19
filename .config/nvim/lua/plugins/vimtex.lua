return {
  {
    "lervag/vimtex",
    ft = "tex",
    build = ":UpdateRemotePlugins",
    config = function()
      -- VimTeX settings
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_syntax_enabled = 0
      vim.g.vimtex_syntax_conceal_disable = 1

      -- Auto command to disable syntax highlighting for .tex files
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.tex",
        command = "syn off",
      })
    end,
  },
}
