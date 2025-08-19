return {
  {
    "RRethy/vim-illuminate",
    opts = {
      providers = { "lsp", "treesitter", "regex" },
      under_cursor = false,
      filetypes_denylist = { "Outline", "TelescopePrompt", "alpha" },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
}
