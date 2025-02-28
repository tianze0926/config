{ lib, pkgs, ... }: {
  options.custom.yazi.preview = lib.mkOption { default = true; };

  config.hm = [
    ({ config, ... }: {
      programs.yazi.enable = true;
      home.packages = with pkgs; [
        fd
        ripgrep
        fzf
        zoxide
        wl-clipboard
      ];
      programs.yazi.keymap.manager.prepend_keymap = let
        mk = on: run: desc: { on = [ on ]; run = run; desc = desc; };
        fish = pkgs.writeText "yazi.fish" ''
          set -x f $argv[1]
          set ff (string join "\n" $argv[2..-1])
          exec fish -C 'set ff (string split "\n" $ff)'
        '';
      in [
        (mk "<C-s>" ''shell "fish ${fish} \"$0\" \"$@\"" --block --confirm'' "Open shell here")
        (mk "l" "plugin smart-enter" "Enter the child directory, or open the file")
      ];
      xdg.configFile."yazi/plugins".source = ./plugins;
      xdg.configFile."yazi/init.lua".source = ./init.lua;
    })
    ({ lib, osConfig, ... }: lib.mkIf osConfig.custom.yazi.preview {
      home.packages = with pkgs; [
        ffmpegthumbnailer
        unar
        jq
        poppler
      ];
    })
  ];
}
