local keymapSilentNore = { noremap = true, silent = true }

-- nvim-tree keymaps
vim.api.nvim_set_keymap('n', '-', ':NvimTreeFindFile<CR>', keymapSilentNore)

-- true zen
vim.api.nvim_set_keymap("n", "<leader>z", ":TZNarrow<CR>", {})
vim.api.nvim_set_keymap("v", "<leader>z", ":'<,'>TZNarrow<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", {})

-- barbar.nvim keymaps
vim.api.nvim_set_keymap('n', 'K', ':BufferNext<CR>', keymapSilentNore)
vim.api.nvim_set_keymap('n', 'J', ':BufferPrevious<CR>', keymapSilentNore)
vim.api.nvim_set_keymap('n', '<leader>x', ':BufferClose<CR>', keymapSilentNore)
vim.api.nvim_set_keymap('n', '<leader>X', ':BufferCloseAllButCurrent<CR>', keymapSilentNore)
vim.api.nvim_set_keymap('n', '<leader>bl', ':BufferOrderByLanguage<CR>', keymapSilentNore)

-- vim-test keymaps
vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<CR>', keymapSilentNore)
vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<CR>', keymapSilentNore)
vim.g['test#ruby#rspec#options'] = { all = '--format documentation' }
vim.g['test#ruby#rspec#executable'] = 'bundle exec rspec'

-- Rails keymaps
vim.api.nvim_set_keymap('n', '<leader>rr', ':!bundle exec rails r %:p<CR>', keymapSilentNore)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Add telescope leader shortcuts
vim.keymap.set('n', '<leader>f', function()
  require('telescope.builtin').find_files { previewer = false }
end)
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>st', require('telescope.builtin').tags)
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>b', function()
  require('telescope.builtin').buffers({
    -- Configuration options go here
    show_all_buffers = true, -- Show all buffers, including hidden ones
    sort_lastused = true,    -- Sort buffers by last used
    ignore_current_buffer = false, -- Do not ignore current buffer
    sort_mru = true,         -- Sort Most Recently Used buffers first
    previewer = true,        -- Enable or disable the previewer
    theme = "cursor",      -- Use a specific theme (e.g., "dropdown")
  })
end)
vim.keymap.set('n', '<leader>so', function()
  require('telescope.builtin').tags { only_current_buffer = true }
end)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Format command
vim.api.nvim_set_keymap("n", "<leader>n", ":Neoformat<CR>", {})
