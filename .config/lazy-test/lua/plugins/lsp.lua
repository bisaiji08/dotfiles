return {
  -- 1. Mason 本体（ツール管理の基盤）
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  -- 2. 自動インストールマネージャー（これを入れる！）
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      -- ここにインストールしたいツールを並べるだけ！
      ensure_installed = {
        "stylua",
        -- 今後、"lua-language-server" や "php-debug-adapter" などを足していけます
      },
      auto_update = true,
      run_on_start = true,
    },
  },
  -- 3. Conform (コード整形)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- 保存前に読み込む
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
      formatters = {
        stylua = {
          -- 明示的に lazy-test 内の設定ファイルを使うように指定
          -- .stylua.toml にリネームした場合は、ここもドットありの名前にしてください
          args = { "--config-path", vim.fn.expand("~/.config/lazy-test/stylua.toml"), "-" },
        },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },
}
