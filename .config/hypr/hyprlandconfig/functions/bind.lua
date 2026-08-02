local M = {}

M.binds = {}

---@param keys string
---@param description string
---@param dispatcher function
---@param options table?
M.bind = function(keys, description, dispatcher, options)
    options = options or {}

    options.description = description

    local bind = {
        keys = keys,
        description = description,
        dispatcher = dispatcher,
        options = options
    }
    table.insert(M.binds, bind)

    return hl.bind(keys, dispatcher, options)
end

---@param path string
M.export_cheatsheet = function(path)
    local binds = {}

    for _, binding in ipairs(M.binds) do
        table.insert(binds, {
            keys = binding.keys,
            description = binding.description
        })
    end

    table.sort(binds, function(a, b)
        return a.keys < b.keys
    end)

    local file = assert(io.open(path, "w"))

    for _, binding in ipairs(binds) do
        file:write(string.format("%-28s  %s\n", binding.keys, binding.description))
    end
    file:close()
end

---@param path string
M.export_cheatsheet_json = function(path)
    local binds = {}

    for _, binding in ipairs(M.binds) do
        table.insert(binds, {
            keys = binding.keys,
            description = binding.description
        })
    end

    table.sort(binds, function(a, b)
        return a.keys < b.keys
    end)

    local file = assert(io.open(path, "w"))

    file:write("[\n")

    for index, binding in ipairs(binds) do
        local keys = binding.keys:gsub("\\", "\\\\"):gsub('"', '\\"')

        local description = binding.description:gsub("\\", "\\\\"):gsub('"', '\\"')

        file:write(string.format('  {"keys":"%s","description":"%s"}%s\n', keys, description,
            index < #binds and "," or ""))
    end

    file:write("]\n")
    file:close()

end

return M
