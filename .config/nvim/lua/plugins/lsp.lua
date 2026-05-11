return {
  -- Mason 本体（ツール管理の基盤）
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  -- Mason LSPConfig
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "intelephense",
      },
    },
  },
  -- 自動インストールマネージャー
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      -- ここにインストールしたいツールを並べるだけ！
      ensure_installed = {
        "stylua",
        -- PHP / Laravel 関連
        "intelephense", -- 高性能なPHP LSP
        "phpstan", -- 静的解析ツール
        "pint", -- Laravel公式のコード整形ツール
        "blade-formatter", -- Bladeテンプレートの整形
      },
      auto_update = true,
      run_on_start = true,
    },
  },
  -- Conform (コード整形)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- 保存前に読み込む
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- PHPはPintを使用
        php = { "pint" },
        -- Bladeの整形設定
        blade = { "blade-formatter" },
      },
      formatters = {
        stylua = {
          args = { "--config-path", vim.fn.stdpath("config") .. "/stylua.toml", "-" },
        },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },
  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Neovim 0.11+ 用の新しいAPIを使用
      vim.lsp.config('intelephense', {
        cmd = { 'intelephense', '--stdio' },
        filetypes = { 'php' },
        settings = {
          intelephense = {
            format = {
              enable = true,
            },
          },
        },
      })
      
      -- バッファで LSP を有効化
      vim.lsp.enable('intelephense')
    end,
  },
}
