local platform = vim.loop.os_uname().sysname
if platform == "Windows_NT" then
  return {
    "equalsraf/neovim-gui-shim",
  }
elseif platform == "Linux" then
  return {}
end
