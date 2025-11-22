vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.softtabstop = 2
opt.autoindent = true -- copy indent from current line when starting new one
opt.breakindent = true
opt.copyindent = true

opt.showmatch = true
opt.matchtime = 1

opt.wrap = true
opt.scrolloff = 8

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.incsearch = true
opt.hlsearch = true
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.backspace = "indent,eol,start"
opt.wildmode = "list:longest"

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

opt.fileencoding = "utf-8"

-- Neovide
if vim.g.neovide then
  vim.o.guifont = "MonaspiceNe Nerd Font:h8"
  vim.g.neovide_background_color = "#181926"
  local padding = 16
  vim.g.neovide_padding_top = padding
  vim.g.neovide_padding_bottom = padding
  vim.g.neovide_padding_right = padding
  vim.g.neovide_padding_left = padding
  vim.g.neovide_cursor_animation_length = 0.150
  vim.g.neovide_theme = "tokyonight"
end
