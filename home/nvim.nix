{ pkgs, ... }: {
  xdg.configFile.nvim.source = ./nvim;

  home.packages = with pkgs; [
    typst-lsp
  ];
}
