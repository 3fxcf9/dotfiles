{pkgs, ...}: {
  programs.neovim = {
    extraLuaConfig =
      /*
      lua
      */
      ''
        vim.g.mapleader = " "
        vim.g.maplocalleader = ","

        local keymap = vim.keymap -- for conciseness

        -- vim.o.langmap = "lh,rj,hk,jr,kl" -- make motions more convenient for my strage keyboard layout
        vim.o.langmap = "rj,jr"
        keymap.set("n", "<C-j>", "<C-r>", { noremap = true }) -- the <C-r> will be remapped for window management

        keymap.set("i", "iu", "<ESC>", { desc = "Exit insert mode with iu" })

        keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

        -- increment/decrement numbers
        keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
        keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

        -- window management
        keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus window at the left" }) -- split window vertically
        keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus window at the top" }) -- split window vertically
        keymap.set("n", "<C-r>", "<C-w>j", { desc = "Focus window at the bottom" }) -- split window vertically
        keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus window at the right" }) -- split window vertically

        keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
        keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
        keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
        keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

        keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
        keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
        keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
        keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
        keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
      '';
  };
}
