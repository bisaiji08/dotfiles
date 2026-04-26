return {
  -- 1. gitsigns.nvim: 行の横にインジケータ表示 & 部分ステージング
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      current_line_blame = false, -- blamer.nvimを使うのでこちらはオフがおすすめ
      signcolumn = true,
      numhl = false,
    },
  },

  -- 2. blamer.nvim: VSCodeのGitLensのように行末にコミットメッセージを表示
  {
    "APZelos/blamer.nvim",
    event = "VeryLazy",
    config = function()
      vim.g.blamer_enabled = 1
      vim.g.blamer_delay = 500
      vim.g.blamer_show_author = 1
      vim.g.blamer_show_date = 1
      -- 表示形式のカスタマイズ（任意）
      vim.g.blamer_template = "<committer> • <summary> • <date>"
    end,
  },

  -- 3. diffview.nvim: 視覚的な差分比較とファイルリストアップ
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    },
    opts = {
      enhanced_diff_hl = true, -- ハイライトを強化
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
    },
  },
}
