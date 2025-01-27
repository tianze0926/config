{ ... }: {
  imports = [
    ({ pkgs, lib, ... }: {
      home.packages = with pkgs; [ python312Full ];
      xdg.configFile."pip/pip.conf".text = lib.generators.toINI {} {
        global.index-url = "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple";
        install.index-url = "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple";
      };
    })
    ({ pkgs, ... }: {
      # wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
      # bash Miniforge3-Linux-x86_64.sh -b
      fhsFishConfig = let
        condaPath = "~/miniforge3/bin/conda";
      in ''
        if test -f ${condaPath}
          eval ${condaPath} "shell.fish" "hook" $argv | source
        end
      '';
    })
  ];
}
