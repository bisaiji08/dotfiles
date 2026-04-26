return {
  -- 1. 使うカラースキームを tokyonight に指定する
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  -- 2. tokyonight 自体の設定で透過を ON にする
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
