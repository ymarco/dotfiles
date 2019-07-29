---------------------------
-- not Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources   = require("beautiful.xresources")
local gears        = require("gears")
local dpi          = xresources.apply_dpi
local gfs          = require("gears.filesystem")

local this_path         = os.getenv("HOME").."/.config/awesome/themes/Guardieye/"
local icons_path        = this_path.."icons/"
local layouts_path      = icons_path.."layouts/"
local titlebar_path     = icons_path.."titlebar/"

local theme = {}

theme.theme_path_debug = themes_path

theme.font = "Ubuntu 12"

theme.bg_normal     = "#3539448a"
theme.bg_focus      = "#6090d5d8"--"#5294e2"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#1f242fbb"
theme.bg_systray    = theme.bg_minimize

theme.fg_normal     = "#c3cddb"
theme.fg_focus      = "#e5eff9"
theme.fg_urgent     = "#ff9999"
theme.fg_minimize   = "#888888"

theme.gap_single_client   = false
theme.useless_gap   = 8
theme.border_width  = 0
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
theme.hotkeys_font = "mono 12"
theme.hotkeys_description_font = "Ubuntu 11"
theme.hotkeys_modifiers_fg = theme.bg_focus
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.progressbar_bg = theme.bg_normal
theme.progressbar_fg = theme.fg_focus
theme.progressbar_shape = gears.shape.rounded_rect
theme.progressbar_bar_shape = theme.progressbar_shape
theme.progressbar_border_width = 3
theme.progressbar_border_color = "#00000000"--theme.bg_normal--theme.bg_minimize

-- Generate taglist squares:
local taglist_square_size = dpi(6)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_shape_border_width = 10
--theme.taglist_shape = gears.shape.rounded_bar

theme.menubar_border_width = 2
theme.menubar_border_color = theme.bg_minimize

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.notification_shape = gears.shape.rounded_rect
theme.notification_bg = theme.normal_bg
theme.notification_border_color = theme.border_focus
theme.notification_border_width = 2
--theme.notification_width = 400
--theme.notification_height = 100
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = icons_path.."/submenu.png"
theme.menu_height = dpi(23)
theme.menu_width  = dpi(150)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = titlebar_path.."close_normal.png"
theme.titlebar_close_button_focus  = titlebar_path.."close_focus.png"

theme.titlebar_minimize_button_normal = titlebar_path.."minimize_normal.png"
theme.titlebar_minimize_button_focus  = titlebar_path.."minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = titlebar_path.."ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = titlebar_path.."ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = titlebar_path.."ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = titlebar_path.."ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = titlebar_path.."sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = titlebar_path.."sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = titlebar_path.."sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = titlebar_path.."sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = titlebar_path.."floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = titlebar_path.."floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = titlebar_path.."floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = titlebar_path.."floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = titlebar_path.."maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = titlebar_path.."maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = titlebar_path.."maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = titlebar_path.."maximized_focus_active.png"

theme.wallpaper = "/home/yoavm448/.wallpapers/wp_black_hole.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh      = layouts_path.."fairhw.png"
theme.layout_fairv      = layouts_path.."fairvw.png"
theme.layout_floating   = layouts_path.."floatingw.png"
theme.layout_magnifier  = layouts_path.."magnifierw.png"
theme.layout_max        = layouts_path.."maxw.png"
theme.layout_fullscreen = layouts_path.."fullscreenw.png"
theme.layout_tilebottom = layouts_path.."tilebottomw.png"
theme.layout_tileleft   = layouts_path.."tileleftw.png"
theme.layout_tile       = layouts_path.."tilew.png"
theme.layout_tiletop    = layouts_path.."tiletopw.png"
theme.layout_spiral     = layouts_path.."spiralw.png"
theme.layout_dwindle    = layouts_path.."dwindlew.png"
theme.layout_cornernw   = layouts_path.."cornernww.png"
theme.layout_cornerne   = layouts_path.."cornernew.png"
theme.layout_cornersw   = layouts_path.."cornersww.png"
theme.layout_cornerse   = layouts_path.."cornersew.png"


theme.widget_music       = icons_path.."note.png"
theme.widget_music_on    = icons_path.."note_on.png"
theme.widget_music_pause = icons_path.."pause.png"
theme.widget_music_stop  = icons_path.."stop.png"

-- Generate Awesome icon:
theme.awesome_icon = icons_path.."arch_icon.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = 'Papirus-Light'

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
