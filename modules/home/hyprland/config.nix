{ ... }: 
{
  wayland.windowManager.hyprland = {
    settings = {
            "$mainMod" = "SUPER";
	    "$terminal" = "kitty";
	    "$fileManager" = "thunar";
	    "$menu" = "rofi -config ~/.dotfiles/.config/rofi/config -show drun -theme ~/.dotfiles/.config/rofi/style.rasi";


            monitor = [
                "eDP-1, 1920x1080, 0x0, 1"
                "HDMI-A-1, 1920x1080, 1920x0, 1"
            ];

            env = [
                "XCURSOR_SIZE,24"
                "HYPRCURSOR_SIZE,24"
                "XDG_SCREENSHOTS_DIR,~/screenshots"
            ];

            input = {
                kb_layout = "pt";

                follow_mouse = 1;
                
                sensitivity = 0;

                touchpad = {
                    natural_scroll = false;
                };
            };

            general = {
                gaps_in = 5;
                gaps_out = 20;

                border_size = 2;

                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45def";
                "col.inactive_border" = "rgba(595959aa)";
                
                layout = "dwindle";
            };

            decoration = {
                rounding = 10;

                active_opacity = 1.0;
                inactive_opacity = 1.0;

                drop_shadow = true;
                shadow_range = 4;
                shadow_render_power = 3;
                "col.shadow" = "rgba(1a1a1aee)";

                blur = {
                    enabled = true;
                    size = 3;
                    passes = 1;

                    vibrancy = 0.1696;
                };
            };

            animations = {
                enabled = true;
                
                bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
                
                animation = [
                    "windows,       1, 7,   myBezier"
                    "windowsOut,    1, 7,   default, popin 80%"
                    "border,        1, 10,  default"
                    "borderangle,   1, 8,   default"
                    "fade,          1, 7,   default"
                    "workspaces,    1, 6,   default"
                ];
            };

            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };

            master = {
                new_status = "master";  
            };

            misc = {
                force_default_wallpaper = 0;
                disable_hyprland_logo = true;
            };

            gestures = {
                workspace_swipe = false;
            };

            device = {
                name = "epic-mouse-v1";
                sensitivity = -0.5;
            };
            
        workspace = [
            "r[1-9],monitor:eDP-1,persistent:true"
            "1,default:true"
            "10,monitor:HDMI-A-1,persistent:true,default:true"
	];

            windowrulev2 = [
                "suppressevent maximize, class:.*"
            ];

            exec-once = [
                #"swww-daemon &"
                #"waybar &"
                "hyprpanel &"
                "swaybg -m fill -i .dotfiles/wallpapers/perfect-blue.jpeg &"
                "hyprlock"
            ];

            bind = [
                # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
                "$mainMod, Return, exec, $terminal"
                "$mainMod, Q, killactive,"
                #"$mainMod, M, exit,"
                "$mainMod, E, exec, $fileManager"
                "$mainMod, V, togglefloating,"
                "$mainMod, R, exec, $menu"
                "$mainMod, P, pseudo," # dwindle
                "$mainMod, J, togglesplit," # dwindle

                # Move focus with mainMod + arrow keys
                "$mainMod, left, movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, up, movefocus, u"
                "$mainMod, down, movefocus, d"

                # Switch workspaces with mainMod + [0-9]
                "$mainMod, 1, workspace, 1"
                "$mainMod, 2, workspace, 2"
                "$mainMod, 3, workspace, 3"
                "$mainMod, 4, workspace, 4"
                "$mainMod, 5, workspace, 5"
                "$mainMod, 6, workspace, 6"
                "$mainMod, 7, workspace, 7"
                "$mainMod, 8, workspace, 8"
                "$mainMod, 9, workspace, 9"
                "$mainMod, 0, workspace, 10"

                # Move active window to a workspace with mainMod + SHIFT + [0-9]
                "$mainMod SHIFT, 1, movetoworkspace, 1"
                "$mainMod SHIFT, 2, movetoworkspace, 2"
                "$mainMod SHIFT, 3, movetoworkspace, 3"
                "$mainMod SHIFT, 4, movetoworkspace, 4"
                "$mainMod SHIFT, 5, movetoworkspace, 5"
                "$mainMod SHIFT, 6, movetoworkspace, 6"
                "$mainMod SHIFT, 7, movetoworkspace, 7"
                "$mainMod SHIFT, 8, movetoworkspace, 8"
                "$mainMod SHIFT, 9, movetoworkspace, 9"
                "$mainMod SHIFT, 0, movetoworkspace, 10"

                # Example special workspace (scratchpad)
                "$mainMod, S, togglespecialworkspace, magic"
                "$mainMod SHIFT, S, movetoworkspace, special:magic"

                # Scroll through existing workspaces with mainMod + scroll
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"

                # own binds
		"$mainMod, F, fullscreen, 2"
		"$mainMod, M, fullscreen, 1"
                "$mainMod, Escape, exec, swaylock"
                "$mainMod Shift, Escape, exec, hyprlock"
                "$mainMod Shift, B, exec, toggle_waybar"
                #"$mainMod, N, swaync-client -t -sw"
                # playerctl
                ",code:172, exec, playerctl --player=playerctld play-pause"
                ",code:174, exec, playerctl --player=playerctld stop"
                ",code:171, exec, playerctl --player=playerctld next"
                ",code:173, exec, playerctl --player=playerctld previous"
                #audio output
                "$mainMod, code:67, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                #eww
                #dashboard
                "$mainMod, Tab, exec, ~/.config/eww/dashboard/launch_dashboard"
            ];
            bindm = [
                # Move/resize windows with mainMod + LMB/RMB and dragging
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"                
            ];
            binde = [
                #own binds
                #brightness
                "$mainMod, code:71, exec, brightnessctl -d intel_backlight s 5%-"
                "$mainMod, code:72, exec, brightnessctl -d intel_backlight s +5%"
                #audio output
                "$mainMod, code:68, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
                "$mainMod, code:69, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
            ];
        };
    };
}
