local M = {}

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

M.binds = {}

return M
