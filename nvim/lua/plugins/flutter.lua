return {
  "akinsho/flutter-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
  config = function()
    require("flutter-tools").setup({
      lsp = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),

      },
      lsp = {
        color = {
          enabled = true,
          background = true,
          foreground = true,
          virtual_text = true,
          virtual_text_str = "■",
        }
      },

      widget_guides = {
        enabled = true,
        debug = true,
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
        },
      },
      closing_tags = {
        highlight = "Variable",
        prefix = ">",
        priority = 10,
        enabled = true,
      },
      debugging = {
        enabled = true,
        log_level = "debug",
        log_root = vim.fn.stdpath("cache") .. "/flutter-logs",
      },
      dev_log = {
        enabled = true,
        open_cmd = "tabnew", -- Try opening logs in a new tab
        popup = true,        -- Ensure logs open properly
      },
      vim.api.nvim_create_user_command("FlutterRun", function()
        -- Open a vertical split
        vim.api.nvim_command("vsplit")
        -- Open a terminal in the new split
        vim.api.nvim_command("term flutter run")
        -- Switch back to the original window (optional)
        vim.api.nvim_command("wincmd p")
      end, {})
      -- debugger = { enabled = true },
    })
  end,
  vim.api.nvim_create_user_command("FlutterRunApp", function()
    -- Run the flutter app in a new windowed environment (Wayland/Hyprland) without using terminal
    vim.api.nvim_command("vsplit")
    vim.api.nvim_command("term QT_QPA_PLATFORM=wayland flutter run")
  end, {})
}
