return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      shell = vim.o.shell, -- Use system shell for better colors
      direction = "horizontal", -- Open logs at the bottom
      size = 15, -- Adjust height of log window
      auto_scroll = true, -- Auto-scroll to latest logs
    })
  end,
}
