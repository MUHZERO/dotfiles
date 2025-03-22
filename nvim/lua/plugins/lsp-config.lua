return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},

        cmp_nvim_lsp.default_capabilities()
      )

      local lspconfig = require("lspconfig")

      --lspconfig.tailwindcss.setup({
      --capabilities = capabilities
      --})
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
        cmd = { "/home/typecraft/.asdf/shims/ruby-lsp" }
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })

      -- 🔥 Add Laravel LSP (intelephense)
      lspconfig.intelephense.setup({
        capabilities = capabilities,
        cmd = { "intelephense", "--stdio" },
        filetypes = { "php" },
        root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
      })
      -- 🔥 Add tailwindcss color support



      vim.api.nvim_create_user_command("FlutterLogs", function()
        require("telescope.builtin").live_grep({
          cwd = vim.fn.stdpath("cache") .. "/flutter-logs",
          prompt_title = "Flutter Logs",
        })
      end, {})


      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})

      -- Add this to your lspconfig section
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.dart",
        callback = function() vim.lsp.buf.format() end,
      })
    end,
  },
}
