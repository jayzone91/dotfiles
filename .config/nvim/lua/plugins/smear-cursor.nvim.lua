-- Plugin: sphamba/smear-cursor.nvim
-- Installed via store.nvim

return {
  "sphamba/smear-cursor.nvim",
  opts = {
    smear_between_buffers = false,
    smear_insert_mode = false,
    stiffness = 0.8, -- default 0.6
    trailing_stiffness = 0.6, -- default 0.45
    stiffness_insert_mode = 0.7, -- default 0.5
    trailing_stiffness_insert_mode = 0.7, -- default 0.5
    damping = 0.95, -- default 0.85
    damping_insert_mode = 0.95, -- default 0.9
    dinstance_stop_animating = 0.5, -- default 0.1
  },
}
