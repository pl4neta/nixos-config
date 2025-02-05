-- Provides:
-- val::volume
--      percentage (integer)
local awful = require("awful")

local volume_script = [[
   sh -c "
   light -G
"]]

local emit_volume_info = function()
    awful.spawn.with_line_callback(volume_script, {
        stdout = function(line)
            percentage = math.floor(tonumber(line))
            awesome.emit_signal("val::volume", percentage)
        end
    })
end

-- Run once to initialize widgets
emit_volume_info()
