return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal toggle left<CR>", {})
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal toggle float<CR>", {})
	-- Show hidden files in NeoTree
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true, -- Set this to true to show hidden files
          hide_dotfiles = false, -- Set this to false to show dotfiles
          hide_hidden = false,  -- Set this to false to show hidden files
        },
      },
    })

  end,
}
