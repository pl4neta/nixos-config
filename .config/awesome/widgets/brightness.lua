-- Provides:
-- val::brightness
--      percentage (integer)
local awful = require("awful")

local brightness_script = [[
   sh -c "
   light -G
"]]

local emit_brightness_info = function()
    awful.spawn.with_line_callback(brightness_script, {
        stdout = function(line)
            percentage = math.floor(tonumber(line))
            awesome.emit_signal("val::brightness", percentage)
        end
    })
end

-- Run once to initialize widgets
emit_brightness_info()
