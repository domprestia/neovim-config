return {
  dir = '.',
  name = 'claude-code',
  keys = {
    {
      '<leader>cc',
      function()
        local buf = vim.g.claude_code_buf
        -- If the terminal buffer exists and is valid, toggle visibility
        if buf and vim.api.nvim_buf_is_valid(buf) then
          -- Find if it's currently displayed in a window
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == buf then
              vim.api.nvim_win_close(win, false)
              return
            end
          end
          -- Buffer exists but not visible, open it in a right split
          vim.cmd 'botright vsplit'
          vim.api.nvim_win_set_buf(0, buf)
        else
          -- Create a new terminal with claude
          vim.cmd 'botright vsplit'
          vim.cmd 'terminal claude'
          vim.g.claude_code_buf = vim.api.nvim_get_current_buf()
          -- Clean up the global when the buffer is deleted
          vim.api.nvim_create_autocmd('BufDelete', {
            buffer = vim.g.claude_code_buf,
            callback = function()
              vim.g.claude_code_buf = nil
            end,
          })
        end
        -- Enter insert mode for the terminal
        vim.cmd 'startinsert'
      end,
      desc = '[C]laude [C]ode toggle',
    },
  },
}
