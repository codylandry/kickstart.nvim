-- nvim v0.8.0
return {
  'crnvl96/lazydocker.nvim',
  lazy = true,
  cmd = { 'LazyDocker' },
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {},
  keys = {
    { '<leader>ld', '<cmd>LazyDocker<cr>', desc = 'LazyDocker' },
  },
}
