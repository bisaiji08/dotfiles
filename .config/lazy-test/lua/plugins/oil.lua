return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      {
        "<leader>e",
        function()
          require("oil").toggle_float()
        end,
        desc = "Open parent directory",
      },
    },
    opts = {
      -- ファイル保存時に自動で反映
      skip_confirm_for_simple_edits = true,
      -- 隠しファイルを表示
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
          return false
        end,
      },
      -- フローティングウィンドウの見た目
      float = {
        padding = 2,
        max_width = 0, -- 0は最大幅
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 10, -- 少し透けさせるとカッコいい
        },
      },
    },
  },
}
