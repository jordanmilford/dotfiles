return {
  'tpope/vim-fugitive', -- Git commands in nvim
  'f-person/git-blame.nvim', -- Git blame viewer
  'tpope/vim-rhubarb', -- Fugitive-companion to interact with github
  { 'ruifm/gitlinker.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = function()
    require"gitlinker".setup()
  end
  }, -- Open github links
  'tpope/vim-surround', -- Surrounding manipulation
  'windwp/nvim-ts-autotag', -- Treesitter HTML tag plugin
  'tpope/vim-repeat', -- . repeat support for vim-surround
  {
    'numToStr/Comment.nvim', -- Comment/uncomment utility
    config = function()
      require('Comment').setup()
    end
  },
  {
    'Vonr/align.nvim',
    branch = "v2",
    lazy = true,
    init = function()
      local NS = { noremap = true, silent = true }

      -- Aligns to 1 character
      vim.keymap.set(
        'x',
        'aa',
        function()
          require'align'.align_to_char({
            length = 1,
          })
        end,
        NS
      )
    end
  },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  -- UI to select things (files, grep results, open buffers...)
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = function()
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
    end
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', config = function()
    require('telescope').load_extension 'fzf'-- Enable telescope fzf native
  end},
  'psliwka/vim-smoothie', -- Smooth scrolling
  'kyazdani42/nvim-web-devicons', -- File type icons
  'romgrk/barbar.nvim', -- Add buffer bar
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          -- theme = "catppuccin",
          component_separators = '|',
          section_separators = '',
        },
      }
    end
  }, -- bFancier statusline
  'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }
    end
  }, -- Add git related info in the signs columns and popups
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
  'sbdchd/neoformat',  -- Format code
  'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code using a fast incremental parsing library
  'nvim-treesitter/nvim-treesitter-textobjects', -- Additional textobjects for treesitter
  'neovim/nvim-lspconfig', -- Using native vim.lsp.config instead
  'nvimtools/none-ls.nvim', -- Collection of sources for none-ls (maintained fork of null-ls)
  'gpanders/editorconfig.nvim', -- EditorConfig support
  'joukevandermaas/vim-ember-hbs', -- Ember.js HBS highlighting
  'jidn/vim-dbml', -- DBML syntax highlighting
  'vim-test/vim-test', -- Run tests from nvim
  {
      'MeanderingProgrammer/render-markdown.nvim',
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
  },
  {
     "m4xshen/hardtime.nvim",
     dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
     opts = {}
  },
}
