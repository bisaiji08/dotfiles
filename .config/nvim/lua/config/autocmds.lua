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

-- バッファが0の時ダッシュボードを表示
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    if vim.v.vim_did_enter == 0 then
      return
    end
    local ft = vim.bo.filetype
    if ft == "oil" or ft == "NvimTree" then
      return
    end
    vim.schedule(function()
      local buffers = vim.fn.getbufinfo({ buflisted = 1 })
      -- 実質的に空（名前なしバッファのみ）かどうか判定
      local is_empty = #buffers == 0 or (#buffers == 1 and buffers[1].name == "" and buffers[1].changed == 0)
      if is_empty and vim.bo.filetype ~= "alpha" then
        -- Alphaを起動
        local status_ok, _ = pcall(require, "alpha")
        if status_ok then
          vim.cmd("Alpha")
          -- 【ここが重要】Alpha起動後、残っている「No Name」バッファを掃除する
          local new_buffers = vim.fn.getbufinfo({ buflisted = 1 })
          for _, buf in ipairs(new_buffers) do
            if buf.name == "" and buf.changed == 0 and buf.bufnr ~= vim.api.nvim_get_current_buf() then
              vim.api.nvim_buf_delete(buf.bufnr, { force = true })
            end
          end
        end
      end
    end)
  end,
})
