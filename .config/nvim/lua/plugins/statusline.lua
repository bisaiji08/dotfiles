return {
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bb", "<cmd>e #<cr>", desc = "Switch to Other Buffer" },
      {
        "<leader>bd",
        function()
          vim.api.nvim_buf_delete(0, { force = true })
        end,
        desc = "Delete Buffer",
      },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete Other Buffers" },
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
    },
    opts = {
      options = {
        close_command = function(n)
          vim.api.nvim_buf_delete(n, { force = true })
        end,
        right_mouse_command = function(n)
          vim.api.nvim_buf_delete(n, { force = true })
        end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(function()
              if nvim_bufferline then
                nvim_bufferline()
              end
            end)
          end)
        end,
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    deprecated = { "catppuccin/nvim" },
    -- Oilのパスを綺麗に取得するための関数
    opts = function()
      local function get_oil_name()
        local ok, oil = pcall(require, "oil")
        if ok then
          return oil.get_current_dir()
        end
        return ""
      end

      return {
        options = {
          theme = "auto", -- あなたが今使っているテーマに合わせる
          component_separators = "|",
          section_separators = { left = "", right = "" },
          -- 特定のファイルタイプでは Lualine を完全に無効化する
          disabled_filetypes = {
            statusline = { "alpha", "dashboard" },
          },
          globalstatus = true,
        },
        sections = {
          lualine_c = {
            {
              "filename",
              fmt = function(name)
                -- ここで外の関数を呼び出す
                if vim.bo.filetype == "oil" then
                  return get_oil_name()
                end
                return name
              end,
            },
          },
        },
      }
    end,
  },
}
