-- Rainfrog floating window functionality
-- This file adds a keybinding to open rainfrog in a floating window

local M = {}

-- Function to open rainfrog in a floating window
function M.open_float()
  -- Create a floating window
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  }

  -- Create a buffer for the floating window
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Launch rainfrog in a terminal inside that buffer
  vim.fn.termopen('rainfrog', {
    on_exit = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })

  -- Set terminal mode immediately
  vim.cmd('startinsert')

  -- Use Ctrl+q to exit instead of just 'q' to avoid conflict when typing
  vim.api.nvim_buf_set_keymap(buf, 't', '<C-q>', [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true })
end

-- Set up the keybinding
function M.setup()
  vim.api.nvim_set_keymap(
    'n',
    '<leader>ls',
    [[<cmd>lua require('custom.rainfrog').open_float()<CR>]],
    { noremap = true, silent = true, desc = 'Open Rainfrog' }
  )
end

return M

