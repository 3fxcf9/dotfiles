return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup(
        { "*" }, -- Apply to all filetypes
        {
          RGB = true,
          RRGGBB = true,
          names = false,
          RRGGBBAA = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
          mode = "background",
        }
      )

      vim.keymap.set("n", "<leader>uc", "<CMD>ColorizerToggle<CR>", { desc = "Toggle Colorizer" })
    end,
  },
}
