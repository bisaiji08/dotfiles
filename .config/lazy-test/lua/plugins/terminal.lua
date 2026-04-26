return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- キーマッピングを lazy に読み込むための設定
    keys = {
      { [[<C-\>]], "<cmd>ToggleTerm<cr>", desc = "ToggleTerm" },
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Terminal (Float)" },
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
    config = function(_, opts)
      -- プラグインを初期化（これがないと opts が効かない）
      require("toggleterm").setup(opts)

      -- エスケープ設定
      function _G.set_terminal_keymaps()
        local t_opts = { buffer = 0 }
        vim.keymap.set("t", "<C-;><C-;>", [[<C-\><C-n>]], t_opts)
      end
      -- ターミナルモードで起動するように固定
      vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
        pattern = "term://*",
        callback = function()
          _G.set_terminal_keymaps()
          vim.defer_fn(function()
            if vim.bo.buftype == "terminal" then
              vim.cmd("startinsert")
            end
          end, 10)
        end,
      })
    end,
  },
}
