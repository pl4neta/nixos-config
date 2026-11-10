---- PROGRAMS ----
local mainMod     = "SUPER"
local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "rofi -config ~/.dotfiles/.config/rofi/config -show drun -theme ~/.dotfiles/.config/rofi/style.rasi"

---- MONITORS ----
hl.monitor({
    output   = "DP-2",
    mode     = "2560x1440@180",
    position = "0x0",
    scale    = "1",
})
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
    mirror   = "DP-2",
})

---- ENVIRONMENT ----
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_SCREENSHOTS_DIR", "~/screenshots")

---- LOOK AND FEEL ----
hl.config({
    input = {
        kb_layout    = "us",
        kb_variant   = "intl",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = false,
        },
    },

    general = {
        gaps_in     = 5,
        gaps_out    = 20,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 0 },
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
    },

    decoration = {
        rounding         = 10,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    debug = {
        disable_logs = false,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

---- ANIMATIONS ----
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

---- DEVICES ----
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---- WINDOW RULES ----
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

---- AUTOSTART ----
hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("qs -c woah")
    hl.exec_cmd("swaybg -m fill -i .dotfiles/wallpapers/perfect-blue.jpeg")
    hl.exec_cmd("~/bin/morse_daemon.py")
end)

---- KEYBINDS ----
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo())

-- Move focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspaces 1-10 (key 0 = workspace 10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = tostring(i) }))
end

-- Scratchpad
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Own binds
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + M",         hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + Escape",    hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("toggle_waybar"))
hl.bind(mainMod .. " + Tab",       hl.dsp.exec_cmd("qs -c woah ipc call dashboard dashToggle"))

-- Morse pipe (on while held, off on release)
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("echo on > /tmp/morse_pipe"))
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("echo off > /tmp/morse_pipe"), { release = true })

-- playerctl
hl.bind("code:172", hl.dsp.exec_cmd("playerctl --player=playerctld play-pause"))
hl.bind("code:174", hl.dsp.exec_cmd("playerctl --player=playerctld stop"))
hl.bind("code:171", hl.dsp.exec_cmd("playerctl --player=playerctld next"))
hl.bind("code:173", hl.dsp.exec_cmd("playerctl --player=playerctld previous"))

-- Audio mute
hl.bind("code:121", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Repeating binds: brightness and volume
hl.bind("code:232", hl.dsp.exec_cmd("brightnessctl -d intel_backlight s 5%-"), { repeating = true })
hl.bind("code:233", hl.dsp.exec_cmd("brightnessctl -d intel_backlight s +5%"), { repeating = true })
hl.bind("code:122", hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("code:123", hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots
local function save_shot(target)
    return "grimshot --notify save " .. target ..
        " images/screenshots/$(TZ=gmt date +'screenshot_%Y-%m-%d_%H-%M-%S.%3N.png')"
end

hl.bind("CTRL + Print",             hl.dsp.exec_cmd(save_shot("screen")))
hl.bind("CTRL + SHIFT + Print",     hl.dsp.exec_cmd(save_shot("area")))
hl.bind("CTRL + ALT + Print",       hl.dsp.exec_cmd(save_shot("active")))
hl.bind("CTRL + SHIFT + ALT + Print", hl.dsp.exec_cmd(save_shot("window")))

hl.bind("Print",             hl.dsp.exec_cmd("grimshot --notify copy screen"))
hl.bind("SHIFT + Print",     hl.dsp.exec_cmd("grimshot --notify copy area"))
hl.bind("ALT + Print",       hl.dsp.exec_cmd("grimshot --notify copy active"))
hl.bind("SHIFT + ALT + Print", hl.dsp.exec_cmd("grimshot --notify copy window"))
