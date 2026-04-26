return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- 高速化のために fzf 拡張を入れるのがエンジニアの鉄則
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      -- これが Ctrl + Shift + F (Live Grep) の代わり
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep (Project Search)" },
      -- ついでにファイル検索 (VS Code の Ctrl + P) も
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    },
    opts = {
      defaults = {
        -- プレビュー画面を右側に出すなど、見た目の調整
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
      },
    },
  },
}
