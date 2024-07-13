if vim.loop.os_uname().sysname == "Linux" then
  return {
    { "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },
    { "aohoyd/broot.nvim", opts = {} },
    {
      "mistricky/codesnap.nvim",
      build = "make",
      config = function()
        require("codesnap").setup({
          save_path = "/mnt/c/Users/Administrator/Downloads/",
          has_breadcrumbs = false,
        })
      end,
    },
    {
      "xiyaowong/transparent.nvim",
      opts = function()
        require("transparent").setup({ -- Optional, you don't have to run setup.
          groups = { -- table: default groups
            "Normal",
            "NormalNC",
            "Comment",
            "Constant",
            "Special",
            "Identifier",
            "Statement",
            "PreProc",
            "Type",
            "Underlined",
            "Todo",
            "String",
            "Function",
            "Conditional",
            "Repeat",
            "Operator",
            "Structure",
            "LineNr",
            "NonText",
            "SignColumn",
            "CursorLine",
            "CursorLineNr",
            "StatusLine",
            "StatusLineNC",
            "EndOfBuffer",
          },
          extra_groups = {}, -- table: additional groups that should be cleared
          exclude_groups = {}, -- table: groups you don't want to clear
        })
      end,
    },
    {
      "CRAG666/code_runner.nvim",
      keys = {
        {
          "<leader>cx",
          function()
            require("code_runner").run_code()
          end,
          desc = "excute code",
        },
      },
      opts = {
        mode = "better_term",
        better_term = {
          number = 1,
        },
        filetype = {
          markdown = function(...)
            local hook = require("code_runner.hooks.preview_pdf")
            require("code_runner.hooks.ui").select({
              Marp = function()
                require("code_runner.commands").run_from_fn("marp --theme-set $MARPT -w -p . &$end")
              end,
              Latex = function()
                hook.run({
                  command = "pandoc",
                  args = { "$fileName", "-o", "$tmpFile", "-t pdf" },
                  preview_cmd = preview_cmd,
                })
              end,
              Beamer = function()
                hook.run({
                  command = "pandoc",
                  args = { "$fileName", "-o", "$tmpFile", "-t beamer" },
                  preview_cmd = preview_cmd,
                })
              end,
              Eisvogel = function()
                hook.run({
                  command = "bash",
                  args = { "./build.sh" },
                  preview_cmd = preview_cmd,
                  overwrite_output = ".",
                })
              end,
            })
          end,
          javascript = "node",
          java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
          kotlin = "cd $dir && kotlinc-native $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt.kexe",
          c = function(...)
            c_base = {
              "cd $dir &&",
              "gcc $fileName -o",
              "/tmp/$fileNameWithoutExt",
            }
            local c_exec = {
              "&& /tmp/$fileNameWithoutExt &&",
              "rm /tmp/$fileNameWithoutExt",
            }
            vim.ui.input({ prompt = "Add more args:" }, function(input)
              c_base[4] = input
              vim.print(vim.tbl_extend("force", c_base, c_exec))
              require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
            end)
          end,
          -- c = {
          --   "cd $dir &&",
          --   "gcc $fileName -o",
          --   "/tmp/$fileNameWithoutExt &&",
          --   "/tmp/$fileNameWithoutExt &&",
          --   "rm /tmp/$fileNameWithoutExt",
          -- },
          cpp = {
            "cd $dir &&",
            "g++ $fileName",
            "-o /tmp/$fileNameWithoutExt &&",
            "/tmp/$fileNameWithoutExt",
          },
          python = "python -u '$dir/$fileName'",
          sh = "bash",
          typescript = "deno run",
          typescriptreact = "yarn dev$end",
          rust = "cd $dir && rustc $fileName && $dir$fileNameWithoutExt",
          dart = "dart",
          cs = function(...)
            local root_dir = require("null-ls.utils").root_pattern("*.csproj")(vim.loop.cwd())
            return "cd " .. root_dir .. " && dotnet run$end"
          end,
        },
      },
    },
  }
else
  return {}
end
