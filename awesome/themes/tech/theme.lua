---------------------------
-- Tech's awesome theme --
---------------------------

theme = {}

theme.font          = "sans 8"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#2BAC00"
theme.fg_focus      = "#02CA0B"
theme.fg_urgent     = "#02CA0B"
theme.fg_minimize   = "#02CA0B"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/home/techwolf12/.config/awesome/tech/taglist/squarefw.png"
theme.taglist_squares_unsel = "/home/techwolf12/.config/awesome/tech/taglist/squarew.png"

theme.tasklist_floating_icon = "/home/techwolf12/.config/awesome/tech/tasklist/floatingw.png"

theme.menu_submenu_icon = "/home/techwolf12/.config/awesome/tech/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg /home/techwolf12/.config/awesome/tech/background.png" }

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/techwolf12/.config/awesome/tech/layouts/fairhw.png"
theme.layout_fairv = "/home/techwolf12/.config/awesome/tech/layouts/fairvw.png"
theme.layout_floating  = "/home/techwolf12/.config/awesome/tech/layouts/floatingw.png"
theme.layout_magnifier = "/home/techwolf12/.config/awesome/tech/layouts/magnifierw.png"
theme.layout_max = "/home/techwolf12/.config/awesome/tech/layouts/maxw.png"
theme.layout_fullscreen = "/home/techwolf12/.config/awesome/tech/layouts/fullscreenw.png"
theme.layout_tilebottom = "/home/techwolf12/.config/awesome/tech/layouts/tilebottomw.png"
theme.layout_tileleft   = "/home/techwolf12/.config/awesome/tech/layouts/tileleftw.png"
theme.layout_tile = "/home/techwolf12/.config/awesome/tech/layouts/tilew.png"
theme.layout_tiletop = "/home/techwolf12/.config/awesome/tech/layouts/tiletopw.png"
theme.layout_spiral  = "/home/techwolf12/.config/awesome/tech/layouts/spiralw.png"
theme.layout_dwindle = "/home/techwolf12/.config/awesome/tech/layouts/dwindlew.png"

theme.awesome_icon = "/home/techwolf12/.config/awesome/tech/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
