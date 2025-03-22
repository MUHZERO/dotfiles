local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

if vim.g.neovide then
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = "torpedo"
  vim.g.neovide_opacity = 0.75
  vim.opt.guifont = "Noto Sans Arabic:h16"
end
vim.opt.arabicshape = true
vim.opt.encoding = "utf-8"
vim.opt.termbidi = true

require("vim-options")
require("lazy").setup("plugins")
-- Add this to your config/main.lua
require("config.highlights")
require("getx_generate")
