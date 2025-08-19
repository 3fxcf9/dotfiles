return {
  {
    "L3MON4D3/LuaSnip",
    -- lazy-load for editing sessions
    event = { "InsertEnter", "BufReadPost" },
    opts = {
      enable_autosnippets = true,
      store_selection_keys = "<C-s>",
      update_events = "TextChanged,TextChangedI",
    },
    config = function(_, opts)
      local luasnip = require("luasnip")
      luasnip.setup(opts)

      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/plugins/luasnip/snippets" })

      -- Filetype extension: markdown -> include latex, tex snippets
      luasnip.filetype_extend("markdown", { "latex", "tex" })

      -- Keymaps
      -- Visual: expand selection into a snippet
      vim.keymap.set("v", "<C-t>", function()
        require("luasnip").expand()
      end, { remap = true, desc = "Luasnip expand" })

      -- Jump forward
      vim.keymap.set({ "i", "n", "v" }, "<Tab>", function()
        require("luasnip").jump(1)
      end, { remap = false, desc = "Luasnip jump forward" })

      -- Jump backward
      vim.keymap.set({ "i", "n", "v" }, "<C-e>", function()
        require("luasnip").jump(-1)
      end, { remap = false, desc = "Luasnip jump backward" })
    end,
  },
}
