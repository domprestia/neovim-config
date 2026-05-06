return {
  "ThePrimeagen/99",
  dependencies = {
    { "saghen/blink.compat", version = "2.*" },
  },
  config = function()
    local _99 = require("99")
    local cwd = vim.uv.cwd()
    local basename = vim.fs.basename(cwd)

    _99.setup({
      -- Uses OpenCodeProvider by default (no need to set explicitly)
      logger = {
        level = _99.DEBUG,
        path = "/tmp/" .. basename .. ".99.debug",
        print_on_error = true,
      },
      completion = {
        source = "blink",
      },
      md_files = {
        "AGENT.md",
      },
    })

    -- Core keymaps
    vim.keymap.set("v", "<leader>9v", function()
      _99.visual()
    end, { desc = "[99] Visual replace" })

    vim.keymap.set("n", "<leader>9x", function()
      _99.stop_all_requests()
    end, { desc = "[99] Stop all requests" })

    vim.keymap.set("n", "<leader>9s", function()
      _99.search()
    end, { desc = "[99] Search" })

    -- Telescope extensions (model/provider switching)
    vim.keymap.set("n", "<leader>9m", function()
      require("99.extensions.telescope").select_model()
    end, { desc = "[99] Select model" })

    vim.keymap.set("n", "<leader>9p", function()
      require("99.extensions.telescope").select_provider()
    end, { desc = "[99] Select provider" })
  end,
}
