local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local volume_bar = wibox.widget{
	{
		{
			{
				widget			= wibox.widget.imagebox,
				image 			= beautiful.widget_volume_white,
				forced_width 	= 20,
				forced_height 	= 20,
			},
			widget = wibox.container.margin,
			right = 10,
		},
		{
   			max_value     	= 100,
   			value         	= 25,
    		forced_height	= 15,
			handle_shape  	= gears.shape.circle,
			handle_width  	= 15,
   			handle_color  	= beautiful.catppuccin_macchiato_lavender,
			bar_shape     	= gears.shape.rounded_rect,
   			bar_height    	= 5,
			bar_color     	= beautiful.catppuccin_macchiato_blue,
   			widget        	= wibox.widget.slider,
			forced_width	= 200
		},
		{
			{
				widget 	= wibox.widget.textbox,
				text 	= '50%',
				valign 	= center,
				font 	= 'sans 10',
			},
			widget = wibox.container.margin,
			left = 10,
		},
		layout = wibox.layout.fixed.horizontal,
	},
	widget = wibox.container.margin,
	top = 5, right = 10, bottom = 5, left = 10,
}

awesome.connect_signal("val::volume", function (value)
    volume_bar.value = value
end)

return volume_bar
