return {
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    dependencies = { "folke/twilight.nvim" },
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.95,
          width = 0.6,
          height = 1,
          options = {
            signcolumn = "no",
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
          },
          gitsigns = { enabled = true },
          tmux = { enabled = true },
        },
        on_open = function()
          -- require("gitsigns.actions").toggle_current_line_blame()
          vim.opt.relativenumber = false
          vim.opt.signcolumn = "no"
          vim.opt.wrap = true
          vim.opt.linebreak = true
        end,
      })
    end,
  },
  {
    "folke/twilight.nvim",
    event = "VeryLazy",
    config = function()
      require("twilight").setup()
    end,
  },
}
