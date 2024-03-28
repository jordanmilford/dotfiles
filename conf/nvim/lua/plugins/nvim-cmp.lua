return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function ()
      -- nvim-cmp setup
      local cmp = require 'cmp'
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local lspkind = require('lspkind')

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end

      cmp.setup {
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
          -- { name = "copilot", group_index = 1 },
          { name = 'nvim_lsp', group_index = 2 },
          -- { name = 'luasnip' },
        }
      }

      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

    end
    -- Rest of your plugin spec
  },
  'hrsh7th/cmp-nvim-lsp',
  -- 'saadparwaiz1/cmp_luasnip',
  -- 'L3MON4D3/LuaSnip', -- Snippets plugin
  'rafamadriz/friendly-snippets', -- vscode format snippets
  'onsails/lspkind.nvim', -- nerd icons in cmp
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        copilot_node_command = 'node', -- Node.js version must be > 16.x
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
}
