return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- キーマッピングを lazy に読み込むための設定
    keys = {
      { [[<C-\>]], "<cmd>ToggleTerm<cr>", desc = "ToggleTerm" },
    },
    opts = {
      size = 20,
      -- <C-\> で開閉する設定（keys と合わせるのが確実です）
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float", -- 透過設定を活かすフローティング
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved", -- 枠線を丸く
        winblend = 0, -- 透過を tokonight に任せる場合は 0 でOK
      },
    },
  },
}
