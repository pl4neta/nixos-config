{ pkgs, ... }:
{
  programs.neovim = 
    /*let
	toLua = str: "lua << EOF\n${str}\nEOF\n";
	toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in*/
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
	${builtins.readFile ../../.config/nvim/options.lua}

    '';

    /*plugins = with pkgs.vimPlugins; [
	{
	    plugin = harpoon;
	    config = toLuaFile ../../.config/nvim/plugin/harpoon.lua;
	}
	{
	    plugin = telescope-nvim;
	    config = toLuaFile ../../.config/nvim/plugin/telescope.lua;
	}
	{
	    plugin = undotree;
	    config = toLuaFile ../../.config/nvim/plugin/undotree.lua;
	}
	{
	    plugin = nvim-treesitter;
	    config = toLuaFile ../../.config/nvim/plugin/treesitter.lua;
	}

    ];*/
  };
}
