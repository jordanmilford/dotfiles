--[[
    This neovim init.lua config started with https://github.com/nvim-lua/kickstart.nvim
    and has been modified by me, https://github.com/jordanmilford
--]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'tpope/vim-fugitive', -- Git commands in nvim
  'f-person/git-blame.nvim', -- Git blame viewer
  'tpope/vim-rhubarb', -- Fugitive-companion to interact with github
  'tpope/vim-surround', -- Surrounding manipulation
  'windwp/nvim-ts-autotag', -- Treesitter HTML tag plugin
  'tpope/vim-repeat', -- . repeat support for vim-surround
  'numToStr/Comment.nvim', -- Comment/uncomment utility
  'kyazdani42/nvim-tree.lua', -- Directory and file browsing utility
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  -- UI to select things (files, grep results, open buffers...)
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'psliwka/vim-smoothie', -- Smooth scrolling
  'dracula/vim', -- Dracula theme
  { 'catppuccin/nvim', name = 'catppuccin' }, -- Catppuccin theme
  { 'rose-pine/neovim', name = 'rose-pine' },
  'kyazdani42/nvim-web-devicons', -- File type icons
  'romgrk/barbar.nvim', -- Add buffer bar
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } }, -- Add git related info in the signs columns and popups
  {
    "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup {
        modes = { -- configurations per mode
          ataraxis = {
            shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
            backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
            minimum_writing_area = { -- minimum size of main window
              width = 120,
              height = 44,
            },
            quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
            padding = { -- padding windows
              left = 44,
              right = 44,
              top = 0,
              bottom = 0,
            },
          },
          minimalist = {
            ignored_buf_types = { "nofile" }, -- save current options from any window except ones displaying these kinds of buffers
            options = { -- options to be disabled when entering Minimalist mode
              number = false,
              relativenumber = false,
              showtabline = 0,
              signcolumn = "no",
              statusline = "",
              cmdheight = 1,
              laststatus = 0,
              showcmd = false,
              showmode = false,
              ruler = false,
              numberwidth = 1
            },
          },
          narrow = {
            --- change the style of the fold lines. Set it to:
            --- `informative`: to get nice pre-baked folds
            --- `invisible`: hide them
            --- function() end: pass a custom func with your fold lines. See :h foldtext
            folds_style = "invisible",
            run_ataraxis = true, -- display narrowed text in a Ataraxis session
          },
          focus = {
            callbacks = { -- run functions when opening/closing Focus mode
              open_pre = nil,
              open_pos = nil,
              close_pre = nil,
              close_pos = nil
            },
          }
        },
        integrations = {
          tmux = true, -- hide tmux status bar in (minimalist, ataraxis)
          kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
            enabled = false,
            font = "+3"
          },
          twilight = false, -- enable twilight (ataraxis)
          lualine = true -- hide nvim-lualine (ataraxis)
        },
      }
    end,
  },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              desc = ' Apps',
              group = 'DiagnosticHint',
              action = 'Telescope app',
              key = 'a',
            },
            {
              desc = ' dotfiles',
              group = 'Number',
              action = 'Telescope dotfiles',
              key = 'd',
            },
          },
        },
      }
    end,
  },
  'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code using a fast incremental parsing library
  'nvim-treesitter/nvim-treesitter-textobjects', -- Additional textobjects for treesitter
  'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
  'onsails/lspkind.nvim', -- nerd icons in cmp
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    -- Rest of your plugin spec
  },
  'hrsh7th/cmp-nvim-lsp',
  -- 'saadparwaiz1/cmp_luasnip',
  -- 'L3MON4D3/LuaSnip', -- Snippets plugin
  'rafamadriz/friendly-snippets', -- vscode format snippets
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        copilot_node_command = os.getenv('HOME') .. "/.nvm/versions/node/v18.15.0/bin/node", -- Node.js version must be > 16.x
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup({
        suggestion = { auto_trigger = true }
      })
    end
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        copilot_node_command = os.getenv('HOME') .. "/.nvm/versions/node/v18.15.0/bin/node", -- Node.js version must be > 16.x
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end
  },
  'gpanders/editorconfig.nvim', -- EditorConfig support
  'joukevandermaas/vim-ember-hbs', -- Ember.js HBS highlighting
  'vim-test/vim-test', -- Run tests from nvim
})

local keymapSilentNore = { noremap = true, silent = true }

--Set highlight on search
vim.o.hlsearch = false

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

-- Set colorscheme
require("catppuccin").setup {
    custom_highlights = function(colors)
        return {
          Comment = { fg = colors.surface2 },
          ["@constant.builtin"] = { fg = colors.surface2, style = {} },
          ["@comment"] = { fg = colors.surface2, style = { "italic" } },
        }
    end,
   integrations = {
      nvimtree = true,
      telescope = true,
      treesitter = true,
      barbar = true,
      gitsigns = true,
      cmp = true
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
}

vim.cmd.colorscheme "rose-pine-moon"

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Use spaces as tabs
vim.api.nvim_set_option('softtabstop', 2)
vim.api.nvim_set_option('shiftwidth', 2)
vim.api.nvim_set_option('tabstop', 2)
vim.api.nvim_set_option('expandtab', true)

-- Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = "catppuccin",
    component_separators = '|',
    section_separators = '',
  },
}

-- Remap , as leader key
vim.keymap.set({ 'n', 'v' }, ',', '<Nop>', { silent = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Enable Comment.nvim
require('Comment').setup()

-- Enable nvim-tree
require('nvim-tree').setup({
  view = {
    width = 60,
    relativenumber = true
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
})

-- Customize nvim-tree icons
-- Customize icons.
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = '✗',
    staged = '✓',
    unmerged = '',
    renamed = '➜',
    deleted = '',
    untracked = '★',
    ignored = '◌',
  },
  folder = {
    default = '',
    open = '',
    symlink = '',
  },
}

-- nvim-tree keymaps
vim.api.nvim_set_keymap('n', '-', ':NvimTreeFindFile<CR>', keymapSilentNore)

local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- Configure barbar.nvim
-- TODO: fix deprecation warning
-- vim.g.bufferline = {
--   closable = false
-- }

vim.o.cmdheight = 0

-- true zen
vim.api.nvim_set_keymap("n", "<leader>zn", ":TZNarrow<CR>", {})
vim.api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", {})
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
vim.g['test#ruby#rspec#executable'] = 'doppler run -- bundle exec rspec'

-- Rails keymaps
vim.api.nvim_set_keymap('n', '<leader>rr', ':!bundle exec rails r %:p<CR>', keymapSilentNore)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 285, on_visual = true })
  end,
  group = highlight_group,
  pattern = '*',
})

-- Map blankline
-- vim.g.indent_blankline_char = '┊'
-- vim.g.indent_blankline_filetype_exclude = { 'help', 'packer', 'txt' }
-- vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
-- vim.g.indent_blankline_show_trailing_blankline_indent = false

-- indent-blankline
-- vim.opt.termguicolors = true
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
--
-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

-- require("indent_blankline").setup {
--     space_char_blankline = " ",
--     char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--         "IndentBlanklineIndent3",
--         "IndentBlanklineIndent4",
--         "IndentBlanklineIndent5",
--         "IndentBlanklineIndent6",
--     },
-- }

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

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
    theme = "dropdown",      -- Use a specific theme (e.g., "dropdown")
    layout_config = {        -- Customize the layout
      width = 0.75,          -- Width of the telescope window as a percentage
      height = 0.5,          -- Height of the telescope window as a percentage
    },
  })
end)
vim.keymap.set('n', '<leader>so', function()
  require('telescope.builtin').tags { only_current_buffer = true }
end)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  ensure_installed = { 'glimmer' },
  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', '<leader>t', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
  -- vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers with default config
local servers = { 'tsserver', 'eslint', 'cssls', 'solargraph', 'yamlls', 'ember' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Configure Ember.js language server
lspconfig.ember.setup {
  filetypes = { "javascript", "handlebars" }
}


-- Configure cssmodules language server
lspconfig.cssmodules_ls.setup {
    on_attach = function (client)
        -- avoid accepting `go-to-definition` responses from this LSP
        client.server_capabilities.definitionProvider = false
    end,
}

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- luasnip setup
-- local luasnip = require 'luasnip'
-- require("luasnip.loaders.from_vscode").lazy_load()
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

-- nvim-cmp setup
local cmp = require 'cmp'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local lspkind = require('lspkind')

cmp.setup {
  snippet = {
    expand = function(args)
      -- luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      -- elseif luasnip.jumpable(-1) then
        -- luasnip.jump(-1)
      else
        fallback()
      end
    end,
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
  sources = {
    { name = "copilot", group_index = 2 },
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' },
  }
}

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- vim: ts=2 sts=2 sw=2 et
