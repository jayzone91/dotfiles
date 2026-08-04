local bind_module = require("hyprlandconfig.functions.bind")
local programs = require("hyprlandconfig.functions.programs")

local bind = bind_module.bind

---------------------
---- KEYBINDINGS ----
---------------------
-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Open Terminal
bind(mainMod .. " + T", "Open Terminal", hl.dsp.exec_cmd(programs.terminal))
bind(mainMod .. " + C", "Open Terminal", hl.dsp.exec_cmd(programs.terminal))

-- Open Browser
bind(mainMod .. " + B", "Open Browser", hl.dsp.exec_cmd(programs.browser))

-- Emoji Picker
bind(mainMod .. " + period", "Open Emoji Picker", hl.dsp.exec_cmd(
    [[rofimoji --selector fuzzel --selector-args="--width=65 --lines=14 --prompt='Emoji  '" --action type --typer wtype --clipboarder wl-copy --prompt "Emoji"]]))

-- Open File Manager
bind(mainMod .. " + E", "Open File Manager", hl.dsp.exec_cmd(programs.fileManager))

-- Clipse UI (Clipboard Manager)
bind(mainMod .. " + SHIFT + V", "Open Clipse UI (Clipboard Manager)", hl.dsp.exec_cmd("clipse-gui"))

-- Close Window (graceful close)
local closeWindowBind = bind(mainMod .. " + Q", "Close Window (graceful close)", hl.dsp.window.close())
-- Kill window (force close)
bind("ALT + F4", "Kill window (force close)", hl.dsp.window.kill())

bind(mainMod .. " + Escape", "Release Application from forced fullscreen", hl.dsp.window.fullscreen_state({
    internal = 0,
    client = 2,
    action = "set",
    layout_aware = false
}))
bind(mainMod .. " + F", "Toggle fullscreen", hl.dsp.window.fullscreen({
    mode = "fullscreen",
    action = "toggle",
    layout_aware = false
}))

-- Switch floating mode for the active window
bind(mainMod .. " + V", "Switch floating mode for the active window", hl.dsp.window.float({
    action = "toggle"
}))

-- Open Applikation Selector
bind(mainMod .. " + SPACE", "Open Application Selector", hl.dsp.exec_cmd(programs.menu))

bind(mainMod .. " + P", "Toggle pseudo fullscreen", hl.dsp.window.pseudo())

bind(mainMod .. " + J", "Toggle split layout", hl.dsp.layout("togglesplit")) -- dwindle only

-- Open Logout Menu
bind(mainMod .. " + SHIFT + E", "Open Logout Menu", hl.dsp.exec_cmd(
    "wlogout --buttons-per-row 5 --column-spacing 20 --margin-left 1250 --margin-right 1250 --margin-top 390 --margin-bottom 390"))
bind(mainMod .. " + M", "Open Logout Menu", hl.dsp.exec_cmd(
    "wlogout --buttons-per-row 5 --column-spacing 20 --margin-left 1250 --margin-right 1250 --margin-top 390 --margin-bottom 390"))

-- Lock Screen
bind(mainMod .. " + L", "Lock Screen", hl.dsp.exec_cmd("hyprlock"))

-- Window Switch
bind("ALT + TAB", "Window Switch",
    hl.dsp.exec_cmd([[sh -c 'hyprctl dispatch fullscreenstate 0 2; walker --provider windows --nosearch']]))

-- Screenshots
-- Screenshot of selected area
bind("Print", "Screenshot of selected area", hl.dsp.exec_cmd([[sh -c 'grim -g "$(slurp)" - | satty --filename -']]))
-- Screenshot of entire screen
bind("SHIFT + Print", "Screenshot of entire screen", hl.dsp.exec_cmd([[grim - | satty --filename -]]))

-- Move focus with mainMod + arrow keys
bind(mainMod .. " + left", "Move focus left", hl.dsp.focus({
    direction = "left"
}))
bind(mainMod .. " + right", "Move focus right", hl.dsp.focus({
    direction = "right"
}))
bind(mainMod .. " + up", "Move focus up", hl.dsp.focus({
    direction = "up"
}))
bind(mainMod .. " + down", "Move focus down", hl.dsp.focus({
    direction = "down"
}))

-- Switch workspaces with mainMod + [0-5]
-- Move active window to a workspace with mainMod + SHIFT + [0-5]
for i = 1, 5 do
    local key = i % 10 -- 10 maps to key 0
    bind(mainMod .. " + " .. key, "Switch to workspace " .. i, hl.dsp.focus({
        workspace = i
    }))
    bind(mainMod .. " + SHIFT + " .. key, "Move active window to workspace " .. i, hl.dsp.window.move({
        workspace = i
    }))
end

-- Example special workspace (scratchpad)
bind(mainMod .. " + S", "Toggle special workspace 'magic'", hl.dsp.workspace.toggle_special("magic"))
bind(mainMod .. " + SHIFT + S", "Move active window to special workspace 'magic'", hl.dsp.window.move({
    workspace = "special:magic"
}))

-- Scroll through existing workspaces with mainMod + scroll
bind(mainMod .. " + mouse_down", "Switch to next workspace", hl.dsp.focus({
    workspace = "e+1"
}))
bind(mainMod .. " + mouse_up", "Switch to previous workspace", hl.dsp.focus({
    workspace = "e-1"
}))

-- Move/resize windows with mainMod + LMB/RMB and dragging
bind(mainMod .. " + mouse:272", "Move window with mouse", hl.dsp.window.drag(), {
    mouse = true
})
bind(mainMod .. " + mouse:273", "Resize window with mouse", hl.dsp.window.resize(), {
    mouse = true
})

-- Laptop multimedia keys for volume and LCD brightness
-- bind("XF86AudioRaiseVolume", "Increase volume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), {
--   locked = true,
--   repeating = true
-- })
-- bind("XF86AudioLowerVolume", "Decrease volume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), {
--   locked = true,
--   repeating = true
-- })
-- bind("XF86AudioMute", "Mute/unmute volume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), {
--   locked = true,
--   repeating = true
-- })
-- bind("XF86AudioMicMute", "Mute/unmute microphone", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), {
--   locked = true,
--   repeating = true
-- })
-- bind("XF86MonBrightnessUp", "Increase brightness", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), {
--   locked = true,
--   repeating = true
-- })
-- bind("XF86MonBrightnessDown", "Decrease brightness", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), {
--   locked = true,
--   repeating = true
-- })

-- Requires playerctl
-- bind("XF86AudioNext", "Next track", hl.dsp.exec_cmd("playerctl next"), {
--   locked = true
-- })
-- bind("XF86AudioPause", "Pause track", hl.dsp.exec_cmd("playerctl play-pause"), {
--   locked = true
-- })
-- bind("XF86AudioPlay", "Play track", hl.dsp.exec_cmd("playerctl play-pause"), {
--   locked = true
-- })
-- bind("XF86AudioPrev", "Previous track", hl.dsp.exec_cmd("playerctl previous"), {
--   locked = true
-- })

-- Cheatsheet

local home = os.getenv("HOME")
local cheatsheet = home .. "/.cache/hyprland-keybinds.txt"
local cheatsheet_json = home .. "/.cache/hypr-keybinds.json"

bind(mainMod .. " + F1", "Show keybinding cheatsheet",
    hl.dsp.exec_cmd("sh -c 'walker --dmenu --placeholder=\"Keybindings\" < \"$HOME/.cache/hyprland-keybinds.txt\"'"))

-- ============================================================
-- SwayOSD
-- ============================================================
bind("XF86AudioRaiseVolume", "Increase volume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), {
    locked = true,
    repeating = true
})
bind("XF86AudioLowerVolume", "Decrease volume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), {
    locked = true,
    repeating = true
})
bind("XF86AudioMute", "Mute/unmute volume", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), {
    locked = true,
    repeating = true
})
bind("XF86AudioMicMute", "Mute/unmute microphone", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), {
    locked = true,
    repeating = true
})
bind("XF86MonBrightnessUp", "Increase brightness", hl.dsp.exec_cmd("swayosd-client --brightness raise"), {
    locked = true,
    repeating = true
})
bind("XF86MonBrightnessDown", "Decrease brightness", hl.dsp.exec_cmd("swayosd-client --brightness lower"), {
    locked = true,
    repeating = true
})
bind("XF86AudioNext", "Next track", hl.dsp.exec_cmd("swayosd-client --playerctl next"), {
    locked = true
})
bind("XF86AudioPause", "Pause track", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), {
    locked = true
})
bind("XF86AudioPlay", "Play track", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), {
    locked = true
})
bind("XF86AudioPrev", "Previous track", hl.dsp.exec_cmd("swayosd-client --playerctl previous"), {
    locked = true
})

-- ============================================================
-- HyprHUD
-- ============================================================
-- bind("SUPER + CTRL + Escape", "Emerhency stop HyprHUD", hl.dsp.exec_cmd("pkill -x hyprhud"))

-- bind(
--   mainMod .. " + SUPER_L",
--   "Show SUPER keybinds",
--   hl.dsp.exec_cmd("hyprhud show super"),
--   { long_press = true, non_consuming = true }
-- )
-- bind(
--   mainMod .. " + SUPER_L",
--   "Hide keybinding HUD",
--   hl.dsp.exec_cmd("hyperhud hide"),
--   { release = true, non_consuming = true }
-- )
--
-- bind(
--   "ALT + ALT_L",
--   "Show ALT keybinds",
--   hl.dsp.exec_cmd("hyperhud show alt"),
--   { long_press = true, non_consuming = true }
-- )
-- bind(
--   "ALT + ALT_L",
--   "Hide keybinging HUD",
--   hl.dsp.exec_cmd("hyperhud hide"),
--   { release = true, non_consuming = true }
-- )

bind_module.export_cheatsheet(cheatsheet)
bind_module.export_cheatsheet_json(cheatsheet_json)
