--Set highlight on search
vim.o.hlsearch = true

--Use system clipboard
vim.opt.clipboard = 'unnamedplus'

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
-- vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Auto-indent
vim.api.nvim_set_option('autoindent', true)

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Use spaces as tabs
vim.api.nvim_set_option('softtabstop', 2)
vim.api.nvim_set_option('shiftwidth', 2)
vim.api.nvim_set_option('tabstop', 2)
vim.api.nvim_set_option('expandtab', true)

-- Remap , as leader key
vim.keymap.set({ 'n', 'v' }, ',', '<Nop>', { silent = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.o.cmdheight = 0

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 285, on_visual = true })
  end,
  group = highlight_group,
  pattern = '*',
})

