local platform = vim.loop.os_uname().sysname
if platform == "Windows_NT" then
  return {
    "equalsraf/neovim-gui-shim",
  }
elseif platform == "Linux" then
  return {
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
end
