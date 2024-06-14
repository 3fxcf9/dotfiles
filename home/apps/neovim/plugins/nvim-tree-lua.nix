{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-tree-lua
    ];
    extraLuaConfig =
      /*
      lua
      */
      ''
        local nvimtree = require("nvim-tree")
          -- recommended settings from nvim-tree documentation
          vim.g.loaded_netrw = 1
          vim.g.loaded_netrwPlugin = 1

          nvimtree.setup({
            view = {
              width = 35,
              relativenumber = true,
            },

            -- change folder arrow icons
            renderer = {
              indent_markers = {
                enable = true,
              },
            },

            -- disable window_picker for explorer to work well with windows splits
            actions = {
              open_file = {
                window_picker = {
                  enable = false,
                },
              },
            },
            filters = {
              custom = { ".DS_Store" },
            },
            git = {
              ignore = false,
            },
          })

          -- set keymaps
          local keymap = vim.keymap -- for conciseness

          keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
          keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
          keymap.set("n", "<leader>et", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" }) -- toggle file explorer on current file
          keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
          keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
      '';
  };
}
