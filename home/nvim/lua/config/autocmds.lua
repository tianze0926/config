-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.filetype.add({
  extension = {
    typ = "typst",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  -- group = augroup("commentstring", { clear = true }),
  pattern = {
    "typst",
  },
  -- callback = function()
  --   vim.opt_local.commentstring = "// %s"
  -- end,
  command = "setlocal commentstring=//%s",
})
