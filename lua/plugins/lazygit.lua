return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>gg', '<cmd>LazyGit<cr>',                  desc = '[G]it TUI' },
    { '<leader>gf', '<cmd>LazyGitCurrentFile<cr>',       desc = '[G]it current [F]ile' },
    { '<leader>gl', '<cmd>LazyGitFilter<cr>',            desc = '[G]it [L]og' },
    { '<leader>gc', '<cmd>LazyGitFilterCurrentFile<cr>', desc = '[G]it [C]ommits (buffer)' },
    { '<leader>g,', '<cmd>LazyGitConfig<cr>',            desc = '[G]it config' },
  },
}
