local function hex_to_rgb(c)
  if c == nil then
    return { 0, 0, 0 }
  end

  c = string.lower(c)
  return {
    tonumber(c:sub(2, 3), 16),
    tonumber(c:sub(4, 5), 16),
    tonumber(c:sub(6, 7), 16),
  }
end

local function blend(foreground, background, alpha)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = hex_to_rgb(background)
  local fg = hex_to_rgb(foreground)

  local blend_channel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format(
    "#%02x%02x%02x",
    blend_channel(1),
    blend_channel(2),
    blend_channel(3)
  )
end

local function darken(hex, amount, bg)
  local default_bg = require("cyberdream.colors").default.bg
  return blend(hex, bg or default_bg, amount)
end

return {
  "rachartier/tiny-glimmer.nvim",
  lazy = true,
  event = "VeryLazy",
  priority = 10,
  config = function()
    require("tiny-glimmer").setup({
      transparency_color = require("cyberdream.colors").default.bg,
      overwrite = {
        yank = {
          enabled = true,
          default_animation = {
            name = "fade",
            settings = {
              from_color = require("cyberdream.colors").default.bg_highlight,
            },
          },
        },
        search = { enabled = true },
        paste = { enabled = true },
        undo = {
          enabled = true,
          default_animation = {
            settings = {
              from_color = darken(
                require("cyberdream.colors").default.red,
                0.5
              ),
            },
          },
        },
        redo = {
          enabled = true,
          default_animation = {
            settings = {
              from_color = darken(
                require("cyberdream.colors").default.green,
                0.5
              ),
            },
          },
        },
      },
    })
  end,
}
