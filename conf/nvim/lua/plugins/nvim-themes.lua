return {
  {
    "f-person/auto-dark-mode.nvim",
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option("background", "dark")
        vim.cmd("colorscheme carbonfox")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option("background", "light")
        vim.cmd("colorscheme dayfox")
      end,
    }, -- auto dark mode
  },
  'dracula/vim', -- Dracula theme
  { 'catppuccin/nvim', name = 'catppuccin' },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { "EdenEast/nightfox.nvim" }
}
