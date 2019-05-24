awful = require("awful")
gears = require("gears")
wibox = require("wibox")
beautiful = require("beautiful")
keys = require("keys")
bar = {}

-- Keyboard map indicator and switcher
bar.keyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
bar.textclock = wibox.widget.textclock()

bar.launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                    				  menu = mymainmenu })

bar.brightness_bar = {
	widget = wibox.widget.progressbar
	{ text = "a", widget = wibox.widget.textbox , align = 'center'},
	value = 0.3,
	color = "#fefe9a",
	forced_width = 120,
	--color = beautiful.bg_focus
}
bar.sound_bar = {
	widget = wibox.widget.progressbar
	{ text = "a", widget = wibox.widget.textbox , align = 'center'},
	value = 0.3,
	color = "#7797ff",
	forced_width = 120,
	--color = beautiful.bg_focus
}
local taglist_buttons = gears.table.join(
		awful.button({ }, 1,
		             function(t) t:view_only() end),
		awful.button({ keys.mod }, 1,
		             function(t)
			             if client.focus then
				             client.focus:move_to_tag(t)
			             end
		             end),
		awful.button({ }, 3, awful.tag.viewtoggle),
		awful.button({ keys.mod }, 3,
		             function(t)
			             if client.focus then
				             client.focus:toggle_tag(t)
			             end
		             end),
		awful.button({ }, 4,
		             function(t) awful.tag.viewnext(t.screen) end),
		awful.button({ }, 5,
		             function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
		awful.button({ }, 1,
		             function(c)
			             if c == client.focus then
				             c.minimized = true
			             else
				             c:emit_signal(
						             "request::activate",
						             "tasklist",
						             { raise = true }
				             )
			             end
		             end),
		awful.button({ }, 2, 
					 function(c) c:kill() end),
		awful.button({ }, 3,
		             function() awful.menu.client_list({ theme = { width = 250 } }) end),
		awful.button({ }, 4,
		             function() awful.client.focus.byidx(1) end),
		awful.button({ }, 5,
		             function() awful.client.focus.byidx(-1) end))

local layoutbox_buttons = gears.table.join(
			awful.button({ }, 1, 
						 function() awful.layout.inc(1) end),
			awful.button({ }, 3, 
						 function() awful.layout.inc(-1) end),
			awful.button({ }, 4, 
						 function() awful.layout.inc(1) end),
			awful.button({ }, 5, 
						 function() awful.layout.inc(-1) end))




function bar.new(s)
	local this = {}
	-- Create a promptbox for each screen
	this.promptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	this.layoutbox = awful.widget.layoutbox(s)
	this.layoutbox:buttons(layoutbox_buttons)	-- Create a taglist widget
	this.taglist  = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
		layout  = { spacing = 12,
        			 --spacing_widget = {
            		 	 --color  = '#dddddd',
            		 	 --forced_width = 4,
            		 	 --widget = wibox.widget.separator 
            		 --},
        			 layout = wibox.layout.fixed.horizontal },
		style = {
				shape_border_width = 2,
				shape_border_color = '#777777',
				--bg_occupied = '#111122',
				--shape = gears.shape.rounded_bar,
				forced_width = 4,
				--shape  = function(cr, width, height) gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true) end,
			},
		}

	-- Create a tasklist widget
	this.tasklist = awful.widget.tasklist {
		screen   = s,
		filter   = awful.widget.tasklist.filter.currenttags,
		buttons  = tasklist_buttons,
		style    = {
				shape_border_width = 0,
				shape_border_color = '#b7b757',
				shape  = gears.shape.rounded_rect,
		},
		layout   = {spacing = 12,
        			--spacing_widget = {
            			 --color  = '#dddddd',
            			 --forced_width = 4,
            			 --widget = wibox.widget.separator 
            		--},
					layout = wibox.layout.flex.horizontal, },
--        			layout = wibox.layout.fixed.horizontal, },
--    	widget_template = {
--        	id     = 'background_role',
--        	widget = wibox.container.background,
--        	{
--            	left  = 10,
--            	right = 10,
--            	widget = wibox.container.margin,
--            	{
--                	layout = wibox.layout.fixed.horizontal,
--                	{
--                    	margins = 2,
--                    	widget  = wibox.container.margin,
--                    	{
--                        	id     = 'icon_role',
--                        	widget = wibox.widget.imagebox,
--                    	},
--                	},
--                	{
--                    	id     = 'text_role',
--                    	widget = wibox.widget.textbox,
--                    	forced_width = 200,
--                	},
--            	},
--        	},
--    	},
}

	-- Create the wibox
	this.wibox = awful.wibar({ position = "top", 
							   screen = s,
							 --bg = "#222222bb",
						   })

	-- Add widgets to the wibox
	this.wibox:setup {
		layout = wibox.layout.align.horizontal,
		spacing = 20,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			bar.launcher,
			this.taglist,
			this.promptbox,
		},
		-- Middle widget
		this.tasklist, 
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
        	spacing_widget = {
            	color  = '#dddddd',
            	forced_width = 2,
            	--widget = wibox.widget.separator 
            },
			spacing = 5,
			{ bar.keyboardlayout, 
			  shape = gears.shape.rounded_rect, 
		  	  bg = beautiful.bg_minimize, fg = beautiful.fg_normal, 
		  	  widget = wibox.container.background, 
		  	  forced_width= 120 },
		  	--awful.widget.watch("/home/yoavm448/desk/lemonbarc/scripts/memory"),
			bar.brightness_bar,
			bar.sound_bar,
			awful.widget.watch('/home/yoavm448/desk/lemonbarc/scripts/battery', 2*60),
			--{ widget = awful. }
			this.layoutbox,
			{ bg = '#ee00ee', 
			  { widget = wibox.container.mirror,
			    bar.textclock,
			    reflection = {horizontal = false, vertical=false},},
			  widget = wibox.container.radialprogressbar,
			  value = 0.7,
			  forced_width = 160
			},
		    wibox.widget.systray(),
		},
	}
	s.bar = this
end

return bar
