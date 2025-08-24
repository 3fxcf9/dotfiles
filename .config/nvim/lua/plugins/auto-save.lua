return {
  {
    "okuuva/auto-save.nvim",
    event = "BufReadPre",
    opts = {
      enabled = true,
      debug = true,
      debounce_delay = 100,
      trigger_events = {
        immediate_save = {
          { "TextChanged", pattern = { "*.mde" } },
          { "TextChangedI", pattern = { "*.mde" } },
        },
        defer_save = { "InsertLeave" },
        cancel_deferred_save = {},
      },
      condition = function(buf)
        local filename = vim.api.nvim_buf_get_name(buf)
        return filename:match("%.mde$") ~= nil
      end,
    },
    keys = {
      { "<leader>ba", "<cmd>ASToggle<CR>", desc = "Toggle autosave" },
    },
  },
}
