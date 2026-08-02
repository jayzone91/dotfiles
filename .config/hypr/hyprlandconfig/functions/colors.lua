local M = {}

local function load_css_colors(path)
    local colors = {}

    local file = assert(io.open(path, "r"))

    for line in file:lines() do
        local name, value = line:match("^%s*@define%-color%s+([%w_%-]+)%s+(#[%x]+)%s*;%s*$")

        if name and value then
            colors[name] = value:sub(2) .. "ff"
        end
    end

    file:close()
    return colors
end

local home = os.getenv("HOME")
M.colors = load_css_colors(home .. "/.config/theme/catppuccin-mocha.css")

return M
