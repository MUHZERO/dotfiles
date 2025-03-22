return {
  "rcarriga/nvim-notify",
   config = function()
     require("notify").setup({
      background_colour = "#1a1b26",
      timeout = 3000,
    })
    vim.notify = require("notify")
  end
}
