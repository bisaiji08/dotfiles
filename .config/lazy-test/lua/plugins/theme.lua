return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true, -- 透過設定
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      -- ここでカラースキームを適用
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
