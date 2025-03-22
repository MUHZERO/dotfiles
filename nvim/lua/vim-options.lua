vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")


vim.g.mapleader = " "
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldenable = true
vim.opt.termbidi = true


-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- neovide past bind
vim.keymap.set("i", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })  -- Paste in Insert Mode
vim.keymap.set("n", "<C-S-v>", '"+p', { noremap = true, silent = true })  -- Paste in Normal Mode
vim.keymap.set("v", "<C-S-v>", '"+p', { noremap = true, silent = true })  -- Paste in Visual Mode



vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

-- Navigate between tabs
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true })   -- Open new tab
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true }) -- Close tab


-- terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

local job_id = 0
vim.keymap.set("n", "<space>to", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)

  job_id = vim.bo.channel
end)

local current_command = ""
vim.keymap.set("n", "<space>te", function()
  current_command = vim.fn.input("Command: ")
end)

vim.keymap.set("n", "<space>tr", function()
  if current_command == "" then
    current_command = vim.fn.input("Command: ")
  end

  vim.fn.chansend(job_id, { current_command .. "\r\n" })
end)
