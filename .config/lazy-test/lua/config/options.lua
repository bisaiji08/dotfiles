-- リーダーキーの設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 行番号・表示系
vim.opt.number = true -- 絶対行番号を表示
vim.opt.relativenumber = true -- 相対行番号を表示
vim.opt.cursorline = true -- カーソルがある行をハイライト
vim.opt.wrap = false -- 行の折り返しを無効
vim.opt.fillchars:append({ eob = " " }) -- 行番号の~を非表示

-- インデント系
vim.opt.tabstop = 2 -- タブ文字を画面上で2マス分として表示
vim.opt.shiftwidth = 2 -- 自動インデントや「>>」で入るスペースの数を2に
vim.opt.softtabstop = 2 -- Tabキーを押したときに入力されるスペースの数を2に
vim.opt.expandtab = true -- Tabキーを押したときにタブ文字ではなくスペースを入れる

-- 改行・システム系
vim.opt.fileformat = "unix" -- LFに固定する場合
vim.opt.fileformats = "unix,dos" -- ファイルを開く時はLF、ダメならCRLFとして試行
vim.opt.clipboard = "unnamedplus" -- OSクリップボードとリンク

-- ステータスライン
vim.opt.laststatus = 3 -- 最下部に表示する
