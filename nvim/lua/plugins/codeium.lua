return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function()
    vim.g.codeium_disable_bindings = 1 -- Disable default keybindings
    vim.keymap.set('i', '<C-Space>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    vim.keymap.set('i', '<C-]>', function() return vim.fn end, { expr = true })
    vim.keymap.set('i', '<C-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
  end
}
