local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
  return
end

catppuccin.setup({
  flavor = "mocha",
  background = {
    light = "mocha",
    dark = "mocha",
  },
  transparent_background = false,
  float = {
    transparent = true,
    solid = true,
  },
  term_colors = true,
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false,
  no_bold = false,
  no_underline = false,
  integrations = {
    blink_cmp = { style = "bordered" },
    fidget = true,
    mason = true,
    nvim_notify = true,
    snacks = { enabled = true, indent_scope_color = "lavender" },
    trouble = true,
    which_key = true,
  },
})

vim.cmd.colorscheme("catppuccin")
