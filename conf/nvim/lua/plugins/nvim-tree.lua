return {
  {
    'kyazdani42/nvim-tree.lua', -- Directory and file browsing utility
    config = function ()
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
    end
  }
}
