local platform = vim.loop.os_uname().sysname
if platform == "Windows_NT" then
  print("windows")
  return {}
elseif platform == "Linux" then
  print("linux")
  return {}
end
