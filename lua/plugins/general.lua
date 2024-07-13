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
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup({})
    end,
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    config = function()
      require("accelerated-jk").setup({
        mode = "time_driven",
        enable_deceleration = false,
        acceleration_motions = { "w", "b" },
        acceleration_limit = 150,
        acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
        deceleration_table = { { 150, 9999 } },
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
}
