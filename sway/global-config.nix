# vim: filetype=i3config
{pkgs ? import <nixpkgs>}:
''
set $dotfiles ~/dotfiles

set_from_resource $base03 i3wm.color8 #002b36
set_from_resource $base02 i3wm.color0 #073642
set_from_resource $base01 i3wm.color10 #586e75
set_from_resource $base00 i3wm.color11 #657b83
set_from_resource $base0 i3wm.color12 #839496
set_from_resource $base1 i3wm.color14 #93a1a1
set_from_resource $base2 i3wm.color7 #eee8d5
set_from_resource $base3 i3wm.color15 #fdf6e3

set_from_resource $yellow i3wm.color3 #b58900
set_from_resource $orange i3wm.color9 #cb4b16
set_from_resource $red i3wm.color1 #dc322f
set_from_resource $magenta i3wm.color5 #d33682
set_from_resource $violet i3wm.color13 #6c71c4
set_from_resource $blue i3wm.color4 #268bd2
set_from_resource $cyan i3wm.color6 #2aa198
set_from_resource $green i3wm.color2 #859900

set $switcheroo exec --no-startup-id timeout -k 5s 1s $HOME/dotfiles/bin/switcheroo.sh
set $rofi rofi
set $flameshot flameshot
# vim: filetype=i3config
# #---Basic Definitions---# #
for_window [class="^.*"] border pixel 2
focus_follows_mouse no
focus_on_window_activation urgent
focus_wrapping no

gaps inner 4
gaps outer 2
set $term alacritty
set $webbrowser firefox
set $filebrowser ranger
set $calculator gnome-calculator
set $mod Mod4

# #---Dropdown Windows---# #
# General dropdown window traits. The order can matter.
for_window [instance="dropdown_*"] floating enable
for_window [instance="dropdown_*"] move scratchpad
for_window [instance="dropdown_*"] sticky enable
for_window [instance="dropdown_*"] scratchpad show
for_window [instance="dropdown_tmuxdd"] resize set 625 450
for_window [instance="dropdown_dropdowncalc"] resize set 800 300
for_window [instance="dropdown_tmuxdd"] border pixel 3
for_window [instance="dropdown_dropdowncalc"] border pixel 2
for_window [instance="dropdown_*"] move position center

# #---Calculator---# #
bindsym $mod+c exec --no-startup-id "$term -e iex"
for_window [instance="alacritty" title="calculator"] floating enable
for_window [instance="alacritty" title="calculator"] move scratchpad
for_window [instance="alacritty" title="calculator"] sticky enable
for_window [instance="alacritty" title="calculator"] scratchpad show
for_window [instance="alacritty" title="calculator"] focus

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:Inconsolata 11

# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
#font pango:DejaVu Sans Mono 8

# Before i3 v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn???t scale on retina/hidpi displays.

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# kill focused window
bindsym $mod+q kill

# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

# change focus
bindsym --release $mod+h $switcheroo h
bindsym --release $mod+j $switcheroo j
bindsym --release $mod+k $switcheroo k
bindsym --release $mod+l $switcheroo l
bindsym --release $mod+Left $switcheroo h
bindsym --release $mod+Down $switcheroo j
bindsym --release $mod+Up $switcheroo k
bindsym --release $mod+Right $switcheroo l

# Move the focused window
bindsym $mod+Ctrl+h move left
bindsym $mod+Ctrl+j move down
bindsym $mod+Ctrl+k move up
bindsym $mod+Ctrl+l move right
bindsym $mod+Ctrl+Left move left
bindsym $mod+Ctrl+Down move down
bindsym $mod+Ctrl+Up move up
bindsym $mod+Ctrl+Right move right

# Resize the focused window
set $resize_amt 25px or 5ppt
bindsym $mod+Shift+h resize shrink width $resize_amt
bindsym $mod+Shift+j resize shrink height $resize_amt
bindsym $mod+Shift+k resize grow height $resize_amt
bindsym $mod+Shift+l resize grow width $resize_amt
bindsym $mod+Shift+Left resize shrink width $resize_amt
bindsym $mod+Shift+Down resize shrink height $resize_amt
bindsym $mod+Shift+Up resize grow height $resize_amt
bindsym $mod+Shift+Right resize grow width $resize_amt

# Move the workspace between displays
bindsym $mod+Ctrl+Shift+h move workspace to output left
bindsym $mod+Ctrl+Shift+j move workspace to output down
bindsym $mod+Ctrl+Shift+k move workspace to output up
bindsym $mod+Ctrl+Shift+l move workspace to output right
bindsym $mod+Ctrl+Shift+Left move workspace to output left
bindsym $mod+Ctrl+Shift+Down move workspace to output down
bindsym $mod+Ctrl+Shift+Up move workspace to output up
bindsym $mod+Ctrl+Shift+Right move workspace to output right

# split in horizontal orientation
bindsym $mod+backslash split h

# split in vertical orientation
bindsym $mod+minus split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

set $mark_cmd i3-input -l 1
# mark a container
bindsym $mod+m exec $mark_cmd -P 'set mark: ' -F 'mark --replace "%s"'
bindsym $mod+Ctrl+m exec $mark_cmd -P 'swap with mark: ' -F 'swap container with mark "%s"'
bindsym $mod+Shift+m exec $mark_cmd -P 'focus mark: ' -F '[con_mark="%s"] focus'

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

bindsym $mod+period sticky toggle

# toggle tiling / floating
bindsym $mod+Ctrl+d floating toggle
bindsym $mod+d focus mode_toggle

# scratchpad
bindsym $mod+grave scratchpad show
bindsym $mod+Ctrl+grave move scratchpad

bindsym $mod+bracketleft focus parent
bindsym $mod+bracketright focus child

# Define names for default workspaces for which we configure key bindings later on.
# We use variables to avoid repeating the names in multiple places.
set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"
set $ws6 "6"
set $ws7 "7"
set $ws8 "8"
set $ws9 "9"
set $ws10 "10"

bindsym $mod+Tab workspace next
bindsym $mod+Shift+Tab workspace prev

# switch to workspace
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8
bindsym $mod+9 workspace $ws9
bindsym $mod+0 workspace $ws10

# move focused container to workspace
bindsym $mod+Ctrl+1 move container to workspace $ws1; workspace $ws1
bindsym $mod+Ctrl+2 move container to workspace $ws2; workspace $ws2
bindsym $mod+Ctrl+3 move container to workspace $ws3; workspace $ws3
bindsym $mod+Ctrl+4 move container to workspace $ws4; workspace $ws4
bindsym $mod+Ctrl+5 move container to workspace $ws5; workspace $ws5
bindsym $mod+Ctrl+6 move container to workspace $ws6; workspace $ws6
bindsym $mod+Ctrl+7 move container to workspace $ws7; workspace $ws7
bindsym $mod+Ctrl+8 move container to workspace $ws8; workspace $ws8
bindsym $mod+Ctrl+9 move container to workspace $ws9; workspace $ws9
bindsym $mod+Ctrl+0 move container to workspace $ws10; workspace $ws10

bindsym $mod+Shift+c reload
bindsym $mod+Shift+r restart
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

bindsym $mod+n exec --no-startup-id $term
bindsym $mod+b exec --no-startup-id $webbrowser
bindsym $mod+i exec --no-startup-id $term -e vim -c ":Note"
bindsym $mod+o exec "$term -e $filebrowser"
bindsym $mod+z exec "$dotfiles/bin/ha-hook studio_toggle"
bindsym $mod+Shift+o exec "$term -e sudo $filebrowser"
bindsym $mod+space exec $rofi -show run -pid "${XDG_RUNTIME_DIR}/rofi.pid" -sidebar-mode
bindsym $mod+v exec "$rofi -modi clipboard:greenclip\ print -show clipboard -run-command '{cmd}'"

bindsym $mod+Shift+2 exec --no-startup-id $flameshot full --clipboard --path ~/Screenshots
bindsym $mod+Shift+3 exec --no-startup-id $flameshot screen --clipboard --path ~/Screenshots
bindsym $mod+Shift+s exec --no-startup-id $flameshot gui --path ~/Screenshots

mode "switcheroo" {
  # Disable all i3 keybindings temporarilly
  bindsym $mod+Escape mode "default"
}

bindsym $mod+g mode "gmode"
mode "gmode" {
  bindsym Escape mode "default"
  bindsym a exec --no-startup-id "$dotfiles/bin/macros/a > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym b exec --no-startup-id "$dotfiles/bin/macros/b > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym c exec --no-startup-id "$dotfiles/bin/macros/c > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym d exec --no-startup-id "$dotfiles/bin/macros/d > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym e exec --no-startup-id "$dotfiles/bin/macros/e > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym f exec --no-startup-id "$dotfiles/bin/macros/f > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym g exec --no-startup-id "$dotfiles/bin/macros/g > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym h exec --no-startup-id "$dotfiles/bin/macros/h > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym i exec --no-startup-id "$dotfiles/bin/macros/i > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym j exec --no-startup-id "$dotfiles/bin/macros/j > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym k exec --no-startup-id "$dotfiles/bin/macros/k > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym l exec --no-startup-id "$dotfiles/bin/macros/l > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym m exec --no-startup-id "$dotfiles/bin/macros/m > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym n exec --no-startup-id "$dotfiles/bin/macros/n > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym o exec --no-startup-id "$dotfiles/bin/macros/o > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym p exec --no-startup-id "$dotfiles/bin/macros/p > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym q exec --no-startup-id "$dotfiles/bin/macros/q > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym r exec --no-startup-id "$dotfiles/bin/macros/r > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym s exec --no-startup-id "$dotfiles/bin/macros/s > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym t exec --no-startup-id "$dotfiles/bin/macros/t > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym u exec --no-startup-id "$dotfiles/bin/macros/u > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym v exec --no-startup-id "$dotfiles/bin/macros/v > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym w exec --no-startup-id "$dotfiles/bin/macros/w > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym x exec --no-startup-id "$dotfiles/bin/macros/x > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym y exec --no-startup-id "$dotfiles/bin/macros/y > /tmp/macro-stdout 2>&1; i3-msg mode default"
  bindsym z exec --no-startup-id "$dotfiles/bin/macros/z > /tmp/macro-stdout 2>&1; i3-msg mode default"
}


# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
	position bottom
  hidden_state hide
  modifier Mod4
  status_command i3status
  #status_command ~/.config/i3/conky-i3bar
  #font pango:Inconsolata 11

  colors {
    background $base03
    statusline $base1
    separator $blue

    #                  $border $background $text
    focused_workspace  $base02 $base02     $blue
    active_workspace   $base02 $base02     $blue
    inactive_workspace $base02 $base02     $base1
    urgent_workspace   $red    $base02     $base1
    binding_mode       $red    $base02     $base1

  }
}


# class                 $border $backgr. $text   $indicator $child_border
client.focused          $red    $base1   $blue03 $blue      $red
client.focused_inactive $base02 $base00  $base03 $base02    $base02
client.unfocused        $base02 $base00  $base03 $base02    $base02
client.urgent           $red    $base00  $base03 $base02    $yellow
client.placeholder      $red    $base00  $base03 $base02    $red

client.background       $base02

exec --no-startup-id dunst

bindsym $mod+Shift+Escape exec --no-startup-id xset s activate
bindsym $mod+Shift+grave exec --no-startup-id xset s activate
exec_always xset s 900
exec_always --no-startup-id xss-lock -- i3lock-pixelated
exec_always --no-startup-id unclutter
exec_always --no-startup-id feh --bg-scale $dotfiles/background.jpg

include /etc/sway/config.d/*
''

# vim:filetype=i3config
