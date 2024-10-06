{ inputs, pkgs, ...}:
{
    home.packages = with pkgs; [
	    inputs.hyprpanel.packages."${system}".default
    ];
}
