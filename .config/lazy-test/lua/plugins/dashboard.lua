return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      -- 1. ロゴ
      dashboard.section.header.val = {
        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
        [[ ████╗  ██╗██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
      }
      -- 2. ボタン設定（Recent Filesはこのボタンの上に自動で出るようにします）
      dashboard.section.buttons.val = {
        dashboard.button("e", "󰉓  file tree", "<cmd>Oil<cr>"),
        dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
        dashboard.button("d", "  Dotfiles", ":e ~/.config/lazy-test<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      -- 3. フッター（ここをシンプルに文字列だけにします）
      dashboard.section.footer.val = "Neovim loaded!"
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.footer.opts.position = "center"

      return dashboard
    end,
    config = function(_, dashboard)
      require("alpha").setup(dashboard.config)
    end,
  },
}
