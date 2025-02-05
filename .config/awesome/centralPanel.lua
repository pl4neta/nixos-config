    local central_panel = awful.popup({
	    type = 'dock',
	    screen = s,
	    minimum_height = 500,
	    maximum_height = 500,
	    minimum_width = 500,
	    maximum_width = 500,
	    bg = '#fff' .. '00',
	    ontop = true,
	    visible = false,
	    hide_on_right_click = true,
	    --placement = function (w)
	    --	awful.placement.center_horizontal(w)
	    --end,
	    --[[placement = function(w)
		    awful.placement.top(w, {
			    margins = {
				    top = 30 + 5,
				    right = 5,
				    bottom = 5,
				    left = 5
			    },
		    })
	    end,]]
	    widget =
	    {
		{
		    {
			layout = wibox.layout.fixed.horizontal,
			{
			    layout = wibox.layout.fixed.vertical,
			    {
				{
				    {
					{
					    layout = wibox.layout.fixed.vertical,
					    {
						layout = wibox.layout.fixed.horizontal,
						{
						    {
							{
							    text = 'WIFI',
							    widget = wibox.widget.textbox
							},
							top = 10,
							right = 10,
						 	bottom = 10,
							left = 10,
							widget = wibox.container.margin
						    },
						    shape = gears.shape.circle,
						    widget = wibox.container.background,
						    bg = '#fff'
						},
						{
						    {
							{
							    text = 'BLUETOOTH',
							    widget = wibox.widget.textbox
							},
							top = 10,
							right = 10,
							bottom = 10,
							left = 10,
							widget = wibox.container.margin
						    },
						    shape = gears.shape.rounded_rect,
						    widget = wibox.container.background,
						    bg = '#fff'
						},
						{
						    {
							{
							    text = 'MICROPHONE',
							    widget = wibox.widget.textbox
							},
							top = 10,
							right = 10,
							bottom = 10,
							left = 10,
							widget = wibox.container.margin
						    },
						    shape = gears.shape.circle,
						    widget = wibox.container.background,
						    bg = '#fff'
					        },
					    },
					    {
						layout = wibox.layout.fixed.horizontal,
						{
						    {
							{
							    text = 'GPS',
							    widget = wibox.widget.textbox
							},
							top = 10,
							right = 10,
							bottom = 10,
							left = 10,
							widget = wibox.container.margin
						    },
						    shape = gears.shape.circle,
						    widget = wibox.container.background,
						    bg = '#fff'
						},
						{
						    {
							{
							    text = 'SCREENSHOT',
							    widget = wibox.widget.textbox
							},
							top = 10,
							right = 10,
							bottom = 10,
							left = 10,
							widget = wibox.container.margin
						    },
						    shape = gears.shape.circle,
						    widget = wibox.container.background,
						    bg = '#fff'
						},
						{
						    {
							{
							    text = 'RECORD',
							    widget = wibox.widget.textbox
							},
							top = 10,
							right = 10,
							bottom = 10,
							left = 10,
							widget = wibox.container.margin
						    },
						    shape = gears.shape.circle,
						    widget = wibox.container.background,
						    bg = '#fff'
						},
					    },
					},
					top = 10,
					right = 10,
					bottom = 10,
					left = 10,
					widget = wibox.container.margin
				    },
				    shape = gears.shape.rounded_rect,
				    widget = wibox.container.background,
				    bg = beautiful.catppuccin_macchiato_base
				},
				top = 5,
				right = 5,
				bottom = 5,
				left = 5,
				widget = wibox.container.margin
			    },
			    {
				{
				    {
					layout = wibox.layout.fixed.vertical,
					{
					    {
						bar_shape = gears.shape.rounded_rect,
						bar_height = 5,
						bar_color = beautiful.catppuccin_macchiato_blue,
						handle_color = beautiful.catppuccin_macchiato_blue,
						handle_shape = gears.shape.circle,
						handle_width = 15,
						value = 75,
						forced_height = 15,
						widget = wibox.widget.slider,
						--widget = wibox.widget.textbox,
						--text = 'teste1',
					    },
					    top = 10,
					    right = 10,
					    bottom = 5,
					    left = 10,
					    widget = wibox.container.margin,
				  	},
					{
					    {
						bar_shape = gears.shape.rounded_rect,
						bar_height = 5,
						bar_color = beautiful.catppuccin_macchiato_blue,
						handle_color = beautiful.catppuccin_macchiato_blue,
						handle_shape = gears.shape.circle,
						handle_width = 15,
						value = 50,
						forced_height = 15,
						widget = wibox.widget.slider,
						--widget = wibox.widget.textbox,
						--text = 'teste2',
					    },
					    top = 5,
					    right = 10,
					    bottom = 10,
					    left = 10,
					    widget = wibox.container.margin,
					},
				    },
				    shape = gears.shape.rounded_rect,
				    widget = wibox.container.background,
				    bg = beautiful.catppuccin_macchiato_base
				},
				top = 5,
				right = 5,
				bottom = 5,
				left = 5,
				widget = wibox.container.margin
		  	    },
			},
			{
			    {
				{
				    {
					
					layout = wibox.layout.fixed.vertical,
					{
					    widget = wibox.widget.textbox,
					    text = 'To Do',
					},
					{
					    widget = wibox.widget.textbox,
					    text = '_____',
					},
					{
					    layout = wibox.layout.fixed.vertical,
					    {
						widget = wibox.widget.textbox,
						text = 'Lorem',
					    },
					    {
						widget = wibox.widget.textbox,
						text = 'Ipsum',
					    },
					    {
						widget = wibox.widget.textbox,
						text = '...',
					    },
					},
				    },
				    top = 10,
				    right = 10,
				    bottom = 10,
				    left = 10,
				    widget = wibox.container.margin,
				},
				shape = gears.shape.rounded_rect,
				widget = wibox.container.background,
				bg = beautiful.catppuccin_macchiato_base,
			    },
			    top = 5,
			    right = 5,
			    bottom = 5,
			    left = 5,
			    widget = wibox.container.margin,
			},
		    },
		    top = 5,
		    right = 5,
		    bottom = 5,
		    left = 5,
		    widget = wibox.container.margin
		},
		widget = wibox.container.background,
		shape = gears.shape.rounded_rect,
		bg = beautiful.catppuccin_macchiato_crust
	    },
    })
    central_panel:bind_to_widget(batteryicon)
    --central_panel:move_next_to(mouse.current_widget_geometry)
    --awful.placement.center_horizontal(central_panel)
end)
