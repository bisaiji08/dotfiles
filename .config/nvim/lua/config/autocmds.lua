-- ヤンクした時にハイライトする
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- 色の種類（IncSearch は検索ヒット時の色）
      timeout = 200, -- 何ミリ秒光らせるか（0.2秒）
    })
  end,
})

-- ステータスラインの表示制御
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  callback = function()
    local win_config = vim.api.nvim_win_get_config(0)
    -- 1. フローティングウィンドウ（Oilなど）を開いている時は表示
    if win_config.relative ~= "" then
      vim.opt.laststatus = 3
    -- 2. ダッシュボード（Alpha）にいる時だけ隠す
    elseif vim.bo.filetype == "alpha" then
      vim.opt.laststatus = 0
    -- 3. それ以外（通常のファイルを開いた時など）は必ず表示
    else
      vim.opt.laststatus = 3
    end
  end,
})

-- 行番号~非表示（予備）
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "NonText", { fg = "NONE", ctermfg = "NONE" })
    -- チルダを表示しない設定（これ自体をサポートしているNeovimのバージョン用）
    vim.opt.fillchars:append({ eob = " " })
  end,
})
