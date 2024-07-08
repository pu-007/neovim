return {
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
}
