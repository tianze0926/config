{ pkgs, lib, ... }: {
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      libsForQt5.fcitx5-qt
      fcitx5-chinese-addons
      fcitx5-lua
      fcitx5-nord
      nur.repos.ruixi-rebirth.fcitx5-pinyin-zhwiki
      nur.repos.ruixi-rebirth.fcitx5-pinyin-moegirl
    ];
  };
}
