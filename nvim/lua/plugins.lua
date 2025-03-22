return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.tailwindcss.setup({
        filetypes = { "html", "blade", "php", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        init_options = {
          userLanguages = {
            blade = "html", -- Treat Blade files as HTML
          },
        },
      })
    end,
  },
  {
    "jwalton512/vim-blade",
    ft = "blade",     -- Load only for Blade files
  },
  {
    "themaxmarchuk/tailwindcss-colors.nvim",
    config = function()
      require("tailwindcss-colors").setup()
    end,
  },
}
