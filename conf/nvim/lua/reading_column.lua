-- A left-anchored reading column for prose buffers (markdown).
--
-- Caps the editing window at `WIDTH` columns and fills the remaining space on
-- the RIGHT with a blank scratch "padding" window, so text stays anchored to
-- the left edge while line length stays bounded. Anchored-left is deliberate:
-- a centered column reads worse. The content window is given `winfixwidth`, so
-- terminal/window resizes are absorbed by the padding window automatically.

local M = {}

local WIDTH = 100 -- total content-window width (text + LEFT_PAD)
local LEFT_PAD = '6' -- blank columns of left margin (via foldcolumn; max '9')
local PAD_FT = 'readingcolumnpad'

-- Top margin: a blank winbar line. (Neovim can't render virtual lines above the
-- topline, so an extmark-based top margin is clipped; winbar is the reliable
-- way to reserve a row at the very top of the window. It's a single line.)
local TOP_BAR = ' '

-- The padding window is made visually seamless: the window separator between it
-- and the content is blanked (fillchars) and blended into the background
-- (winhighlight -> a highlight linked to Normal), so the text just appears to
-- stop at WIDTH with empty space after it, rather than next to a second window.
local SEP_HL = 'ReadingColumnSeparator'
local FILLCHARS = 'eob: ,vert: ' -- blank the end-of-buffer ~ and the separator

-- Content side: blend the shared separator, the foldcolumn left margin, and the
-- winbar top margin into the background.
local CONTENT_WINHL = 'WinSeparator:'
  .. SEP_HL
  .. ',FoldColumn:Normal,WinBar:Normal,WinBarNC:Normal'
-- Padding side: same, plus NormalNC:Normal so the (always inactive) pad window
-- isn't dimmed by colorschemes into a visible background block, and a blended
-- end-of-buffer so its empty area matches the editor background.
local PAD_WINHL = 'WinSeparator:' .. SEP_HL .. ',NormalNC:Normal,EndOfBuffer:Normal'

-- Per-tab state, keyed by tabpage handle: { content = <win>, pad = <win> }.
local state = {}

local function win_valid(w)
  return w ~= nil and vim.api.nvim_win_is_valid(w)
end

local function teardown(tab)
  local s = state[tab]
  if not s then
    return
  end
  if win_valid(s.content) then
    vim.wo[s.content].winfixwidth = false
    vim.wo[s.content].winhighlight = ''
    vim.wo[s.content].fillchars = ''
    vim.wo[s.content].foldcolumn = '0'
    vim.wo[s.content].winbar = ''
  end
  if win_valid(s.pad) then
    pcall(vim.api.nvim_win_close, s.pad, true)
  end
  state[tab] = nil
end

local function build(content_win)
  local tab = vim.api.nvim_win_get_tabpage(content_win)

  -- Create the padding window at the far right with a throwaway scratch buffer.
  -- noautocmd: don't let the new buffer/window re-trigger our own BufWinEnter.
  -- Blend the window separator into the background. Linked to Normal so it
  -- tracks the colorscheme; redefined on each build in case a colorscheme swap
  -- cleared it.
  vim.api.nvim_set_hl(0, SEP_HL, { link = 'Normal' })

  vim.cmd('noautocmd botright vnew')
  local pad_win = vim.api.nvim_get_current_win()
  local pad_buf = vim.api.nvim_get_current_buf()
  vim.bo[pad_buf].buftype = 'nofile'
  vim.bo[pad_buf].bufhidden = 'wipe'
  vim.bo[pad_buf].swapfile = false
  vim.bo[pad_buf].buflisted = false
  vim.bo[pad_buf].filetype = PAD_FT
  local wo = vim.wo[pad_win]
  wo.number = false
  wo.relativenumber = false
  wo.signcolumn = 'no'
  wo.cursorline = false
  wo.colorcolumn = ''
  wo.list = false
  wo.fillchars = FILLCHARS
  wo.winhighlight = PAD_WINHL

  -- Anchor: fix the content window to WIDTH; the pad absorbs the remainder and
  -- any later resizes (because content has winfixwidth set). Blank the
  -- separator/eob on the content side too, so it's invisible whichever window
  -- owns the shared separator, and add a blended foldcolumn as a left margin.
  vim.api.nvim_set_current_win(content_win)
  vim.api.nvim_win_set_width(content_win, WIDTH)
  vim.wo[content_win].winfixwidth = true
  vim.wo[content_win].fillchars = FILLCHARS
  vim.wo[content_win].winhighlight = CONTENT_WINHL
  vim.wo[content_win].foldcolumn = LEFT_PAD
  vim.wo[content_win].winbar = TOP_BAR

  state[tab] = { content = content_win, pad = pad_win }
end

-- Reconcile the column for the current window/buffer.
local function refresh()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype

  -- Never react to our own padding window.
  if ft == PAD_FT then
    return
  end

  local tab = vim.api.nvim_get_current_tabpage()
  local cur = vim.api.nvim_get_current_win()
  local s = state[tab]

  if ft == 'markdown' then
    -- Already set up and healthy.
    if s and win_valid(s.content) and win_valid(s.pad) then
      return
    end
    -- Stale state (a window was closed) — clean up before rebuilding.
    if s then
      teardown(tab)
    end
    -- Only build for a lone window, so we don't fight user-made splits.
    if #vim.api.nvim_tabpage_list_wins(tab) ~= 1 then
      return
    end
    -- Need enough room to be worth padding.
    if vim.api.nvim_win_get_width(cur) <= WIDTH then
      return
    end
    build(cur)
  elseif s and vim.bo[buf].buftype == '' then
    -- Moved to a real, non-markdown file: tear the column down.
    teardown(tab)
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup('ReadingColumn', { clear = true })

  -- Schedule the reconcile: on startup (markdown opened from the command line)
  -- neovim is still settling its window layout, and building synchronously
  -- races that. Deferring also lets focus settle on the real target buffer.
  vim.api.nvim_create_autocmd('BufWinEnter', {
    group = group,
    callback = function()
      vim.schedule(function()
        pcall(refresh)
      end)
    end,
  })

  -- Quitting the content window (`:q`) is the common path. Close the padding
  -- window *before* the quit proceeds, so we don't try to close a window from
  -- inside WinClosed (which raises E855) and so `:q` then sees a lone window and
  -- quits as expected.
  vim.api.nvim_create_autocmd('QuitPre', {
    group = group,
    callback = function()
      local tab = vim.api.nvim_get_current_tabpage()
      local s = state[tab]
      if s and vim.api.nvim_get_current_win() == s.content and win_valid(s.pad) then
        state[tab] = nil
        pcall(vim.api.nvim_win_close, s.pad, true)
      end
    end,
  })

  -- Backstop for non-quit closes (e.g. :close, buffer wipe). The pad close is
  -- scheduled because closing a window directly inside WinClosed raises E855.
  vim.api.nvim_create_autocmd('WinClosed', {
    group = group,
    callback = function(args)
      local closed = tonumber(args.match)
      for tab, s in pairs(state) do
        if s.content == closed then
          local pad = s.pad
          state[tab] = nil
          vim.schedule(function()
            if win_valid(pad) then
              pcall(vim.api.nvim_win_close, pad, true)
            end
          end)
        elseif s.pad == closed then
          if win_valid(s.content) then
            vim.wo[s.content].winfixwidth = false
          end
          state[tab] = nil
        end
      end
    end,
  })
end

return M
