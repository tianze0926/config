{ pkgs, ... }: {
  home.file.".config/nvim".source = ./nvim;

  home.packages = with pkgs; [
    typst-lsp
  ];
}
