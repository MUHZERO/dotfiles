return {
  "stevearc/oil.nvim",
  config = function()
    local oil = require("oil")
    oil.setup({
      default_file_explorer = false, -- Disable Oil from auto-opening
    })
    -- Keybinding to toggle Oil floating window
    vim.keymap.set("n", "-", oil.toggle_float, {})

    -- Keybinding to change directory (set working directory to current Oil path)
    vim.keymap.set("n", "<leader>cd", function()
      local oil_path = oil.get_current_dir()
      if oil_path then
        local fs_path = vim.fn.fnamemodify(oil_path, ":p") -- Convert to absolute path
        vim.cmd("cd " .. fs_path)
        print("Changed directory to: " .. fs_path)
      else
        print("Error: Could not get Oil directory")
      end
    end, { desc = "Change working directory to Oil buffer path" })
  end,
}
