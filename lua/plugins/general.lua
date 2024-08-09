return {
  -- Lazy
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
  { "ellisonleao/gruvbox.nvim" },
  -- Tools
  -- {
  --   "keaising/im-select.nvim",
  --   config = function()
  --     require("im_select").setup({})
  --   end,
  -- },
  {
    "rainbowhxch/accelerated-jk.nvim",
    config = function()
      require("accelerated-jk").setup({
        mode = "time_driven",
        enable_deceleration = true,
        acceleration_motions = { "w", "b" },
        acceleration_limit = 150,
        acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
        deceleration_table = { { 200, 3 }, { 300, 7 }, { 450, 11 }, { 600, 15 }, { 750, 21 }, { 900, 9999 } },
      })
    end,
  },
  {
    "declancm/cinnamon.nvim",
    version = "*", -- use latest release
    opts = {
      -- change default options here
    },
  },
  -- Code
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "yapf", "black" },
        -- Use a sub-list to run only the first available formatter
        javascript = { "prettierd", "prettier" },
        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = { "codespell" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
      },
    },
  },
  { "noearc/jieba.nvim", dependencies = { "noearc/jieba-lua" }, ft = { "markdown" } },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "rescript-lang/tree-sitter-rescript",
    },
    opts = function(_, opts) -- this is needed so you won't override your default nvim-treesitter configuration
      vim.list_extend(opts.ensure_installed, {
        "rescript",
      })

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.rescript = {
        install_info = {
          url = "https://github.com/rescript-lang/tree-sitter-rescript",
          branch = "main",
          files = { "src/scanner.c" },
          generate_requires_npm = false,
          requires_generate_from_grammar = true,
          use_makefile = true, -- macOS specific instruction
        },
      }
    end,
  },
  { "rescript-lang/vim-rescript", ft = "rescript" },
  { "ActivityWatch/aw-watcher-vim" },
  {
    "nvimdev/dashboard-nvim",
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        config = {
          shortcut = {
            {
              action = "lua LazyVim.pick()()",
              desc = " Find File",
              icon = " ",
              key = "1",
            },
            {
              action = "FzfLua live_grep",
              desc = " Find Text",
              icon = " ",
              key = "2",
            },
            {
              action = "ene | startinsert",
              desc = " New File",
              icon = " ",
              key = "3",
            },
            {
              action = 'lua require("persistence").load()',
              desc = " Restore Session",
              icon = " ",
              key = "4",
            },
            {
              action = function()
                vim.api.nvim_input("<cmd>qa<cr>")
              end,
              desc = " Quit",
              icon = " ",
              key = "q",
            },
          },
          mru = { limit = 10, icon = "  ", label = "Recent Files", cwd_only = false },
          project = { enable = true, limit = 3, icon = "  ", label = "Projects", action = "FzfLua files cwd=" },
          packages = { enable = false },
          footer = {},
        },
      })
    end,
  },
}
