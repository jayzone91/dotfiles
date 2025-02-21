local formatter = require("setup.server.formatter")
local linter = require("setup.server.linter")

local ensure_installed = {}

for _, value in pairs(formatter) do
  for i = 1, #value, 1 do
    table.insert(ensure_installed, value[i])
  end
end

for _, value in pairs(linter) do
  for i = 1, #value, 1 do
    table.insert(ensure_installed, value[i])
  end
end

require("mason-tool-installer").setup({
  ensure_installed = ensure_installed,
  auto_update = true,
})
