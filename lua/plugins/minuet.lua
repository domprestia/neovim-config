-- AI inline suggestions via minuet-ai (virtual text, Claude backend)
return {
  'milanglacier/minuet-ai.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'InsertEnter',
  config = function()
    require('minuet').setup {
      provider = 'claude',
      provider_options = {
        claude = {
          model = 'claude-haiku-4-5',
          api_key = 'ANTHROPIC_API_KEY',
          max_tokens = 256,
          optional = {
            max_tokens = 128,
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { '*' },
        keymap = {
          accept = '<Tab>',
          accept_line = '<A-l>',
          next = '<A-]>',
          prev = '<A-[>',
          dismiss = '<A-e>',
        },
      },
      throttle = 200,
      debounce = 100,
      notify = 'verbose',
    }

  end,
}
