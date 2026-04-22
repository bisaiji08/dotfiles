-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LFに固定する場合
vim.opt.fileformat = "unix"
-- ファイルを開く時はLF、ダメならCRLFとして試行
vim.opt.fileformats = "unix,dos"
