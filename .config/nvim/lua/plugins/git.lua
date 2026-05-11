return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- 必須
      "sindrets/diffview.nvim", -- 必須ではないが、連携すると強力
      "nvim-telescope/telescope.nvim", -- 必須ではないが、選択UIとして推奨
    },
    config = true,
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
  },

  -- diffview.nvim: 視覚的な差分比較とファイルリストアップ
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    },
    opts = {
      enhanced_diff_hl = true, -- ハイライトを強化
      view = {
        merge_tool = { layout = "diff3_mixed" },
      },
      keymaps = {
        view = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
      },
    },
  },

  -- gitsigns.nvim: 行の横にインジケータ表示 & 部分ステージング
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      current_line_blame = false, -- blamer.nvimを使うのでこちらはオフがおすすめ
      signcolumn = true,
      numhl = false,
    },
  },

  -- blamer.nvim: VSCodeのGitLensのように行末にコミットメッセージを表示
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

  -- {
  --   "kdheepak/lazygit.nvim",
  --   cmd = {
  --     "LazyGit",
  --     "LazyGitConfig",
  --     "LazyGitCurrentFile",
  --     "LazyGitFilter",
  --     "LazyGitFilterCurrentFile",
  --   },
  --   -- キーマップの設定
  --   keys = {
  --     { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  --     { "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
  --   },
  --   -- 依存関係（telescope を使っているなら連携できます）
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
}
