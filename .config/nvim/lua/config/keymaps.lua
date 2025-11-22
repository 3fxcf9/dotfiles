vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- Navigate between the two most recent buffers
keymap.set("n", "<leader>bb", ":b#<CR>", { desc = "Switch to most recent buffer" })

-- o O but for normal mode
keymap.set("n", "<leader>o", "o<ESC>", { desc = "Append line below cursor" })
keymap.set("n", "<leader>O", "O<ESC>", { desc = "Append line above the cursor" })

-- Spelling
keymap.set("n", "<leader>uS", "<cmd>set nospell<cr>", { desc = "Disable spelling" })
keymap.set("n", "<leader>us", "<cmd>set spell<cr>", { desc = "Enable spelling" })

-- Better up/down motion (line wrap)
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Window motion
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })

-- Resize windows
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move lines
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Escape clear search highlight
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- LSP
keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>")
keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", { desc = "LSP Format" })
keymap.set(
  "n",
  "<leader>lH",
  "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr })<cr>",
  { desc = "Toggle inlay hints" }
)

-- Exit terminal
keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Exit terminal" })

-- Ui
keymap.set("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle word wrapping" })
keymap.set("n", "<leader>uW", "<cmd>set linebreak!<cr>", { desc = "Toggle linebreak" })
keymap.set("n", "<leader>uz", "<cmd>ZenMode<cr>", { desc = "ZenMode" })

-- Splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>ss", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })

-- Keep cursor centered while scrolling
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement
