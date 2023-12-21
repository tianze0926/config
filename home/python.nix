{ ... }: {
  imports = [
    ({ pkgs, lib, ... }: {
      home.packages = with pkgs; [ python312Full ];
      xdg.configFile."pip/pip.conf".text = lib.generators.toINI {} {
        global.index-url = "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple";
      };
    })
    ({ pkgs, ... }: {
      home.packages = with pkgs; [ conda ];
      programs.fish.functions.conda-fish = ''
        eval /home/leo/.conda/bin/conda "shell.fish" "hook" $argv | source
      '';
      home.file.".condarc".text = ''
        channels:
          - defaults
        show_channel_urls: true
        default_channels:
          - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
          - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
          - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
        custom_channels:
          conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
          msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
          bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
          menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
          pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
          pytorch-lts: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
          simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
          deepmodeling: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/
      '';
    })
  ];
}
