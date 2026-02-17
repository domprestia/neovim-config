-- Null-ls configuration for formatting and linting
return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  opts = {},
  config = function()
    local null_ls = require 'null-ls'

    -- Shouldn't be putting this here I think, but it really only relates to this config so meh.
    vim.diagnostic.config {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = true,
      severity_sort = true,
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    null_ls.setup {
      debug = false,
      sources = {
        null_ls.builtins.formatting.prettierd.with {
          timeout = 10000,
          -- prefer_local = 'node_modules/.bin',
        },
        require 'none-ls.diagnostics.eslint_d',
        -- require('none-ls.diagnostics.eslint_d').with({
        --   condition = function(utils)
        --     -- Only run eslint_d if we have proper ESLint config files
        --     return utils.root_has_file({ "package.json", ".eslintrc.js", ".eslintrc.json", ".eslintrc.yml", ".eslintrc.yaml", "eslint.config.js" })
        --   end,
        --   filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
        -- }),
        require 'none-ls.code_actions.eslint_d',
      },

      default_timeout = 60000,
      diagnostics_format = '[#{c}] #{m} (#{s})',
      notify_format = '[null-ls] %s',

      -- This formats the buffers on save
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                bufnr = bufnr,
                group = augroup,
                async = false,
                timeout_ms = 10000,
                filter = function(c)
                  -- Prefer null-ls for formatting
                  return c.name == 'null-ls'
                end,
              }
              -- Fuck all of this, just reload the buffer, its quick
              -- vim.defer_fn(function()
              --   vim.cmd 'e'
              -- end, 1000)
              -- vim.cmd 'e'
              -- Force null-ls to recheck diagnostics after format
              -- null_ls.generator { filetype = vim.bo[bufnr].filetype, method = null_ls.methods.DIAGNOSTICS }()
            end,
          })

          -- vim.api.nvim_create_autocmd('BufWritePost', {
          --   group = augroup,
          --   buffer = bufnr,
          --   callback = function()
          --     vim.diagnostic.reset(nil, bufnr)
          --     -- Trigger a fresh diagnostic request
          --     client.request('textDocument/diagnostic', { textDocument = vim.lsp.util.make_text_document_params() }, nil, bufnr)
          --     -- Give a small delay to ensure format is complete
          --     -- vim.defer_fn(function()
          --     --   -- Trigger null-ls to refresh diagnostics
          --     --   null_ls.vim.cmd 'silent! e!' -- Reload buffer to get fresh diagnostics
          --     -- end, 100)
          --   end,
          -- })

          -- vim.api.nvim_create_autocmd('BufWritePost', {
          --   group = augroup,
          --   buffer = bufnr,
          --   callback = function()
          --     -- Request diagnostics from the LSP server
          --     client.request('textDocument/diagnostic', { textDocument = vim.lsp.util.make_text_document_params(bufnr) }, function()
          --       -- Refresh the displayed diagnostics
          --       vim.diagnostic.show()
          --     end, bufnr)
          --   end,
          -- })
        end
      end,
    }
  end,
}
