-- TypeScript tools
return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {
    on_attach = function(client)
      -- Disable formatting so biome handles it instead
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
      tsserver_file_preferences = {
        -- Always prefer path aliases (e.g. `@/lib/foo`) over relative paths (`../../lib/foo`)
        -- on auto-imports. Falls back to relative when no alias matches.
        importModuleSpecifierPreference = 'non-relative',
      },
    },
  },
}
