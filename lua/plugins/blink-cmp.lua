-- Autocompletion
return {
  'Saghen/blink.cmp',
  version = '*',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  opts = {
    keymap = {
      preset = 'default',
      -- Accept suggestion with C-y (mirrors old nvim-cmp binding)
      ['<C-y>'] = { 'accept', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-space>'] = { 'show', 'fallback' },
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        lsp = {
          name = 'LSP',
          module = 'blink.cmp.sources.lsp',
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              -- typescript-tools stores the import source path in data.entryNames[1].source
              -- but doesn't populate labelDetails.description with it
              if
                item.data
                and item.data.entryNames
                and item.data.entryNames[1]
                and type(item.data.entryNames[1]) == 'table'
                and item.data.entryNames[1].source
              then
                item.labelDetails = item.labelDetails or {}
                if not item.labelDetails.description or item.labelDetails.description == '' then
                  item.labelDetails.description = item.data.entryNames[1].source
                end
              end
            end
            return items
          end,
        },
      },
    },
    completion = {
      trigger = { prefetch_on_insert = false },
    },
  },
}
