-- LSP settings for Nvim 0.11+
-- Migrated from require'lspconfig' to vim.lsp.config/vim.lsp.enable

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', '<leader>gd', vim.lsp.buf.declaration, opts)
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
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
  -- vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers with default config
local servers = { 'ts_ls', 'eslint', 'cssls', 'solargraph', 'yamlls' }
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end

-- Configure Ember.js language server
vim.lsp.config('ember', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascript", "handlebars" }
})
vim.lsp.enable('ember')

-- Configure cssmodules language server
vim.lsp.config('cssmodules_ls', {
  on_attach = function (client)
    -- avoid accepting `go-to-definition` responses from this LSP
    client.server_capabilities.definitionProvider = false
  end,
  capabilities = capabilities,
})
vim.lsp.enable('cssmodules_ls')

-- Configure Lua language server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

vim.lsp.config('lua_ls', {
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
})
vim.lsp.enable('lua_ls')
