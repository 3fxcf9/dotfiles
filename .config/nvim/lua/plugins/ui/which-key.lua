return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    preset = "helix",
    spec = {
      { "<leader>b", group = "Buffers" },
      { "<leader>l", group = "LSP", icon = "" },
      { "<leader>e", group = "Nvim-Tree", icon = "󰙅" },
      { "<leader>s", group = "Splits", icon = "" },
      { "<leader>t", group = "Tabs" },
      { "<leader>f", group = "Telescope" },
      { "<leader>u", group = "UI/UX" },
    },
  },
}
