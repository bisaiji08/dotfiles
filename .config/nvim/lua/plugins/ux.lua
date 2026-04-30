return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- 起動を遅らせて負荷を減らす
    opts = {
      preset = "helix",
      layout = {
        horizontal_area = 1, -- 1にすると、可能な限り縦に並べようとします
        spacing = 3, -- キーと説明の間のスペース
      },
      spec = {
        {
          mode = { "n", "x" },
          { "<leader>l", "<cmd>Lazy<cr>", desc = "Lazy", icon = "󰒲 " },
          { "<leader>t", group = "terminal", icon = " " },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui" },
          { "<leader>x", group = "diagnostics/quickfix" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- 通知を綺麗にするならこれもセットで
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        -- LSP の通知などを Noice で処理する設定（後で LSP を入れる時に活きます）
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.styled_parts"] = true,
          ["navigation.lsp.signature_help"] = true,
        },
      },
      -- プリセット設定を有効化
      presets = {
        bottom_search = false, -- 検索バーを下に置くか（falseで中央）
        command_palette = true, -- コマンド入力を中央のパレット形式にする
        long_message_to_split = true,
        inc_rename = false, -- 増分リネームを使うか
        lsp_doc_border = true, -- LSPドキュメントに枠線を付ける
      },
    },
  },

  -- 通知を浮かせるためのプラグイン
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      stages = "fade",
      render = "minimal", -- シンプルな見た目に
      background_colour = "#000000", -- 透明感を出すための設定
    },
  },
}
