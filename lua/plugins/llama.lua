-- Local FIM code completion via llama.cpp
-- Requires `llama-server` running. Start it with `llama-start` (see ~/.bashrc),
-- or manually: llama-server --fim-qwen-1.5b-default
-- Step up to 3B for better quality at ~2x latency:
--   llama-server --fim-qwen-3b-default
return {
  'ggml-org/llama.vim',
  event = 'InsertEnter',
  init = function()
    vim.g.llama_config = {
      endpoint_fim = 'http://127.0.0.1:8012/infill',
      endpoint_inst = 'http://127.0.0.1:8012/v1/chat/completions',

      auto_fim = true,
      show_info = 2,

      -- FIM keymaps
      keymap_fim_trigger     = '<leader>llf',
      keymap_fim_accept_full = '<Tab>',
      keymap_fim_accept_line = '<S-Tab>',
      keymap_fim_accept_word = '<leader>ll]',

      -- Instruction-edit keymaps
      keymap_inst_trigger  = '<leader>lli',
      keymap_inst_retry    = '<leader>llr',
      keymap_inst_continue = '<leader>llc',
      keymap_inst_accept   = '<Tab>',
      keymap_inst_cancel   = '<Esc>',

      -- Generation budget tuned for Ryzen 5 PRO 5650U (CPU + Vega 7 Vulkan)
      n_predict = 128,
      t_max_prompt_ms = 500,
      t_max_predict_ms = 1000,

      -- Context
      n_ctx = 8192,
      ring_n_chunks = 16,
      ring_chunk_size = 64,
      ring_scope = 1024,
      ring_update_ms = 1000,
    }
  end,
}
