local M = {}

M.binds = {}

---@param keys string
---@param description string
---@param dispatcher function
---@param options table?
M.bind = function(keys, description, dispatcher, options)
    local bind = {
        keys = keys,
        description = description,
        dispatcher = dispatcher,
        options = options or {}
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

return M
