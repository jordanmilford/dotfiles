return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function ()
      -- nvim-cmp setup
      local luasnip = require("luasnip")
      local cmp = require 'cmp'
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local lspkind = require('lspkind')

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()

      cmp.setup {
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping(function(fallback)
               if cmp.visible() then
                   if luasnip.expandable() then
                       luasnip.expand()
                   else
                       cmp.confirm({
                           select = true,
                       })
                   end
               else
                   fallback()
               end
           end),

           ["<Tab>"] = cmp.mapping(function(fallback)
             if cmp.visible() then
               cmp.select_next_item()
             elseif luasnip.locally_jumpable(1) then
               luasnip.jump(1)
             else
               fallback()
             end
           end, { "i", "s" }),

           ["<S-Tab>"] = cmp.mapping(function(fallback)
             if cmp.visible() then
               cmp.select_prev_item()
             elseif luasnip.locally_jumpable(-1) then
               luasnip.jump(-1)
             else
               fallback()
             end
           end, { "i", "s" }),
        }),
        formatting = {
          format = function(entry, vim_item)
            -- Get the basic formatting from lspkind
            vim_item = lspkind.cmp_format({
              mode = 'symbol', -- show only symbol annotations
              maxwidth = 50, -- prevent the popup from showing more than provided characters
              ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
            })(entry, vim_item)
            -- Add source name to the right
            vim_item.menu = ({
              copilot = "[Copilot]",
              nvim_lsp = "[LSP]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end
        },
        sources = cmp.config.sources({
          { name = "copilot" },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' }
        }),
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        }
      }

      -- Configure autopairs integration
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  'saadparwaiz1/cmp_luasnip',
  'rafamadriz/friendly-snippets',
  'onsails/lspkind.nvim',
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        copilot_node_command = 'node',
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
