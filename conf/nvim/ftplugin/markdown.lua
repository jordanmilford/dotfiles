-- Markdown reading experience: word-wrap, hidden gutter, and a centered column.

vim.opt_local.wrap = true
vim.opt_local.linebreak = true -- break at word boundaries, not mid-word
vim.opt_local.breakindent = true -- indent wrapped lines
vim.opt_local.showbreak = "↪ "
vim.opt_local.conceallevel = 2 -- let render-markdown hide markup
vim.opt_local.concealcursor = "nc"
vim.opt_local.number = false -- GitHub/Obsidian have no gutter
vim.opt_local.relativenumber = false
vim.opt_local.signcolumn = "no"
vim.opt_local.spell = true

-- The left-anchored reading column is managed by lua/reading_column.lua, which
-- builds it on markdown buffers and tears it down elsewhere. It lives there
-- rather than here because this ftplugin only runs when a buffer's filetype is
-- first set, not when revisiting an already-loaded buffer.
