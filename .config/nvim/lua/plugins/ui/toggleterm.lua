return {
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "float",
        open_mapping = [[<leader>tt]],
        float_opts = {
          border = "curved",
          width = 130,
          height = 30,
        },
      })
    end,
  },
}
