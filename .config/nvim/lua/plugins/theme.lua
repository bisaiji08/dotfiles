return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true, -- 透過設定
      styles = {
        sidebars = "transparent",
        floats = "dark",
      },
      on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = "#fab387", bold = true }
        local lineColor = "#5a7a58"
        hl.LineNr = { fg = lineColor }
        hl.LineNrAbove = { fg = lineColor }
        hl.LineNrBelow = { fg = lineColor }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      -- ここでカラースキームを適用
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
