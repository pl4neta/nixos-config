{ lib, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
	    "$font" = "JetBrainsMono Nerd Font";
      "$font2" = "Montserrat";
      "$text" = "rgb(198, 208, 245)";
      "$accent" = "rgba(186, 187, 241, .5)";
      "$base" = "rgba(165, 173, 206, .2)";
      "$warn" = "rgba(229, 200, 144, .5)";
      "$err" = "rgba(231, 130, 132, .5)";

# GENERAL
	    "general" = {
		    "hide_cursor" = true;
	    };

# BACKGROUND
	    "background" = {
		    "monitor" = "";
		    "path" = "${lib.custom.relativeToRoot "assets/wallpapers/perfect-blue.jpeg"}";
		    "blur_passes" = 3;
        "blur_size" = 1;
	    };

	    label = [
# TIME
	    {
		    "monitor" = "";
		    "text" = "$TIME";
		    "color" = "$text";
		    "font_size" = 130;
		    "font_family" = "$font";
		    "position" = "0, 155";
		    "halign" = "center";
		    "valign" = "center";
	    }
# DATE
	    {
		    "monitor" = "";
		    "text" = ''cmd[update:1000] echo "- $(date +"%A, %B %d") -"'';
		    "color" = "$text";
		    "font_size" = 30;
		    "font_family" = "$font2";
		    "position" = "0, 45";
		    "halign" = "center";
		    "valign" = "center";
	    }
# USER
      {
        "monitor" = "";
        "text" = "  $USER";
        "color" = "$text";
        "font_size" = "16";
        "font_family" = "$font2";
        "position" = "0, -155";
        "halign" = "center";
        "valign" = "center";
      }
	    ];

# USER-BOX
    "shape" = {
      "monitor" = "";
      "size" = "350, 50";
      "color" = "$base";
      "rounding" = "15";
      "border_size" = "0";
      "rotate" = "0";
      "position" = "0, -155";
      "halign" = "center";
      "valign" = "center";
    };

    "input-field" = {
      "monitor" = "";
      "size" = "350, 50";
      "outline_thickness" = "0";
      "rounding" = "15";
      "dots_size" = "0.25";
      "dots_spacing" = "0.4";
      "dots_center" = "true";
      "inner_color" = "$base";
      "color" = "$text";
      "font_color" = "$text";
      "fade_on_empty" = "false";
		  "check_color" = "$accent";
		  "capslock_color" = "$warn";
		  "fail_color" = "$err";
      "placeholder_text" = ''<i><span foreground="##ebdbb2e5">Enter Password</span></i>'';
      "hide_input" = "false";
      "position" = "0, -225";
      "halign" = "center";
      "valign" = "center";
    };
    };
  };
}
