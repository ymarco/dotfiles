local gears         = require("gears")
local awful         = require("awful")
local naughty       = require("naughty")
local lain          = require("lain")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.autofocus")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local keys = {}

local quake = lain.util.quake({app = "st", argname = "-n %s", height = 1, width = 0.3, horiz = "right"})

keys.mod = "Mod4"
keys.alt = "Mod1"
keys.callbacks = {}
keys.callbacks = setmetatable(keys.callbacks, { __index = 
		function(t, v) return function()
    			naughty.notify({ title = "key callback unset",
    						 	 text = "for function "..v.."." })
			end 
		end 
	}
)

function get_unoccupied_tag()
	for i,t in ipairs(screen.selected_tags) do
		if #t.clients() == 0 then return i end
	end
end

function get_prev_occupied_tag()
	
end

keys.globals = gears.table.join(
		awful.key({ keys.mod, }, "c",
		          hotkeys_popup.show_help,
		          { description = "show help", group = "awesome" }),
		awful.key({ keys.mod, }, "Left",
		          awful.tag.viewprev,
		          { description = "view previous", group = "tag" }),
		awful.key({ keys.mod, }, "Right",
		          awful.tag.viewnext,
		          { description = "view next", group = "tag" }),
		awful.key({ keys.mod, }, "t",
		          awful.tag.history.restore,
		          { description = "go to privieus", group = "tag" }),
		-- mod+{h,j,k,l} change focus in their vim direction
		awful.key({ keys.mod, }, "j",
		          function() awful.client.focus.bydirection("down") end,
		          { description = "focus below", group = "client" }),
		awful.key({ keys.mod, }, "k",
		          function() awful.client.focus.bydirection("up") end,
		          { description = "focus above", group = "client" }),
		awful.key({ keys.mod, }, "h",
		          function() awful.client.focus.bydirection("left") end,
		          { description = "focus to the left", group = "client" }),
		awful.key({ keys.mod, }, "l",
		          function() awful.client.focus.bydirection("right") end,
		          { description = "focus right", group = "client" }),
		awful.key({ keys.mod, }, "w",
		          function() keys.callbacks.show_menu() end,
		          { description = "show main menu", group = "awesome" }),
		awful.key({ keys.mod, }, "n",
				  awful.client.focus.history.previous,
				  { description = "focus previous client", group = "client" }),

-- Layout manipulation
		-- mod+shift+{h,j,k,l} swap clients in their vim direction
		awful.key({ keys.mod, "Shift" }, "j",
		          function() awful.client.swap.bydirection("down") end,
		          { description = "swap with client below", group = "client" }),
		awful.key({ keys.mod, "Shift" }, "k",
		          function() awful.client.swap.bydirection("up") end,
		          { description = "swap with client above", group = "client" }),
		awful.key({ keys.mod, "Shift" }, "h",
		          function() awful.client.swap.bydirection("left") end,
		          { description = "swap with client to the left", group = "client" }),
		awful.key({ keys.mod, "Shift" }, "l",
		          function() awful.client.swap.bydirection("right") end,
		          { description = "swap with client to the right", group = "client" }),
		--idk
		awful.key({ keys.mod, "Control" }, "j",
		          function() awful.screen.focus_relative(1) end,
		          { description = "focus the next screen", group = "screen" }),
		awful.key({ keys.mod, "Control" }, "k",
		          function() awful.screen.focus_relative(-1) end,
		          { description = "focus the previous screen", group = "screen" }),
		awful.key({ keys.mod, }, "u",
		          awful.client.urgent.jumpto,
		          { description = "jump to urgent client", group = "client" }),
		awful.key({ keys.mod, }, "Tab",
		          function()
			          awful.client.focus.history.previous()
			          if client.focus then
				          client.focus:raise()
			          end
		          end,
		          { description = "go back", group = "client" }),

-- Standard program
		awful.key({ keys.mod, }, "Return",
		          function() awful.spawn(terminal) end,
		          { description = "open a terminal", group = "launcher" }),
		awful.key({ keys.mod, }, "BackSpace",
		          awesome.restart,
		          { description = "reload awesome", group = "awesome" }),
		awful.key({ keys.mod, "Shift" }, "BackSpace",
		          awesome.quit,
		          { description = "quit awesome", group = "awesome" }),

--		awful.key({ keys.mod, }, "g",
--		          function() awful.tag.incmwfact(0.05) end,
--		          { description = "increase master width factor", group = "layout" }),
--		awful.key({ keys.mod, }, "c",
--		          function() awful.tag.incmwfact(-0.05) end,
--		          { description = "decrease master width factor", group = "layout" }),
--		awful.key({ keys.mod, "Shift" }, "h",
--		          function() awful.tag.incnmaster(1, nil, true) end,
--		          { description = "increase the number of master clients", group = "layout" }),
--		awful.key({ keys.mod, "Shift" }, "l",
--		          function() awful.tag.incnmaster(-1, nil, true) end,
--		          { description = "decrease the number of master clients", group = "layout" }),
--		awful.key({ keys.mod, "Control" }, "h",
--		          function() awful.tag.incncol(1, nil, true) end,
--		          { description = "increase the number of columns", group = "layout" }),
--		awful.key({ keys.mod, "Control" }, "l",
--		          function() awful.tag.incncol(-1, nil, true) end,
--		          { description = "decrease the number of columns", group = "layout" }),
		awful.key({ keys.alt }, "space",
		          function() awful.layout.inc(1) end,
		          { description = "select next", group = "layout" }),
		-- awful.key({ keys.mod, "Shift" }, "space",
		          -- function() awful.layout.inc(-1) end,
		          -- { description = "select previous", group = "layout" }),

		awful.key({ keys.mod, "Control" }, "n",
		          function()
			          local c = awful.client.restore()
			          -- Focus restored client
			          if c then
				          c:emit_signal(
						          "request::activate", "key.unminimize", { raise = true }
				          )
			          end
		          end,
		          { description = "restore minimized", group = "client" }),

-- Prompt
		awful.key({ keys.mod }, "r",
		          function() keys.callbacks.runpromptbox() end,
		          { description = "run prompt", group = "launcher" }),

		awful.key({ keys.mod }, "x",
		          function()
			          awful.prompt.run {
				          prompt = "Run Lua code: ",
				          textbox = awful.screen.focused().mypromptbox.widget,
				          exe_callback = awful.util.eval,
				          history_path = awful.util.get_cache_dir() .. "/history_eval"
			          }
		          end,
		          { description = "lua execute prompt", group = "awesome" }),
		awful.key({ keys.mod }, "z",
				  function() quake:toggle() end,
				  { deskription = "toggle quake?", group = "launcher" }),

-- Menubar
		awful.key({ keys.mod }, "p",
		          function() menubar.show() end,
		          { description = "show the menubar", group = "launcher" }),
-- system
		awful.key({ }, 'XF86MonBrightnessDown', 
				  --function()  awful.spawn('xbacklight -dec 5') end,
				  function()  keys.callbacks.brightness_decrease() end,
				  { desctiption = 'decreace brightness', group = 'system' }),
		awful.key({ }, 'XF86MonBrightnessUp', 
				  function()  keys.callbacks.brightness_increase() end,
				  { desctiption = 'decreace brightness', group = 'system' }),
		awful.key({ }, 'XF86AudioRaiseVolume',
				  function() keys.callbacks.sound_increase() end,
				  { description = "increase volume", group = "system" }),
		awful.key({ }, 'XF86AudioLowerVolume',
				  function() keys.callbacks.sound_decrease() end,
				  { description = "decrease volume", group = "system" }),

		awful.key({ keys.mod, }, "space",
		          function() keys.callbacks.change_keyboard_layout() end,
		          { description = "change keyboard layout", group = "system" })
)

keys.clients = gears.table.join(
		awful.key({ keys.mod, }, "f",
		          function(c)
			          c.fullscreen = not c.fullscreen
			          c:raise()
		          end,
		          { description = "toggle fullscreen", group = "client" }),
		awful.key({ keys.mod, }, ".",
		          function(c) c:kill() end,
		          { description = "close", group = "client" }),
		--awful.key({ "Alt",  }, "Tab", awful.client.floating.toggle,
		          --{ description = "toggle floating", group = "client" }),
		awful.key({ keys.mod, "Control" }, "Return",
		          function(c) c:swap(awful.client.getmaster()) end,
		          { description = "move to master", group = "client" }),
		awful.key({ keys.mod, }, "o",
		          function(c) c:move_to_screen() end,
		          { description = "move to screen", group = "client" }),
--		awful.key({ keys.mod, }, "t",
--		          function(c) c.ontop = not c.ontop end,
--		          { description = "toggle keep on top", group = "client" }),
--		awful.key({ keys.mod, }, "b",
--		          function(c)
			          -- The client currently has the input focus, so it cannot be
			          -- minimized, since minimized clients can't have the focus.
--			          c.minimized = true
--		          end,
--		          { description = "minimize", group = "client" }),
		awful.key({ keys.mod, }, "m",
		          function(c)
			          c.maximized = not c.maximized
			          c:raise()
		          end,
		          { description = "(un)maximize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 8 do
	keys.globals = gears.table.join(
			keys.globals,
	-- View tag only.
			awful.key({ keys.mod }, "#" .. i + 11,
			          function()
				          local screen = awful.screen.focused()
				          local tag    = screen.tags[i]
				          if tag then
					          tag:view_only()
				          end
			          end,
			          { description = "view tag #" .. i, group = "tag" }),
	-- Toggle tag display.
			awful.key({ keys.mod, "Control" }, "#" .. i + 11,
			          function()
				          local screen = awful.screen.focused()
				          local tag    = screen.tags[i]
				          if tag then
					          awful.tag.viewtoggle(tag)
				          end
			          end,
			          { description = "toggle tag #" .. i, group = "tag" }),
	-- Move client to tag.
			awful.key({ keys.mod, "Shift" }, "#" .. i + 11,
			          function()
				          if client.focus then
					          local tag = client.focus.screen.tags[i]
					          if tag then
						          client.focus:move_to_tag(tag)
					          end
				          end
			          end,
			          { description = "move focused client to tag #" .. i, group = "tag" }),
	-- Toggle tag on focused client.
			awful.key({ keys.mod, "Control", "Shift" }, "#" .. i + 11,
			          function()
				          if client.focus then
					          local tag = client.focus.screen.tags[i]
					          if tag then
						          client.focus:toggle_tag(tag)
					          end
				          end
			          end,
			          { description = "toggle focused client on tag #" .. i, group = "tag" })
					)
end

return keys
