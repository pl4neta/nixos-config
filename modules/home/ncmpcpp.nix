{pkgs, ...}:
{
    programs.ncmpcpp = {
        enable = true;
        package = pkgs.ncmpcpp.override {
            visualizerSupport = true;
        };
        mpdMusicDir = "$HOME/music";
        settings = {
            visualizer_fps = 60;
            visualizer_data_source = "/tmp/mpd.fifo";
            visualizer_output_name = "my_fifo";
            visualizer_type = "spectrum";
            visualizer_in_stereo = "yes";
            visualizer_look = "●●";

            progressbar_look = "◈◆◇";
            progressbar_elapsed_color = "white";

            now_playing_prefix = " ";
            song_status_format = " $2%a $4⟫$3⟫ $8%t $4⟫$3⟫ $5%b ";
            autocenter_mode = "yes";
            centered_cursor = "yes";

            display_bitrate = "yes";
            mouse_support = "yes";

            startup_screen = "playlist";
        };
    };
}
