{ pkgs, lib, inputs, opt, ... }: {
  home.packages = [
    pkgs.python312Full inputs.fix-python.packages.${opt.system}.default
  ];
  home.file.".config/pip/pip.conf".text = lib.generators.toINI {} {
    global.index-url = "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple";
  };
}
