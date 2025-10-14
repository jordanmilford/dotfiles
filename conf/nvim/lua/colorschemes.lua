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
