{ pkgs, config, ... }: {
  programs.mbsync.enable = true;
  services.mbsync.enable = true;
  services.mbsync.postExec = "${pkgs.notmuch}/bin/notmuch new";
  programs.notmuch.enable = true;
  programs.neomutt = {
    enable = true;
    sidebar.enable = true;
    vimKeys = true;
    extraConfig = ''
      source ${pkgs.neomutt}/share/neomutt/colorschemes/vombatidae.neomuttrc
      auto_view text/html
      alternative_order text/enriched text/plain text/html
    '';
  };
  home.file.".mailcap".text = ''
    text/html; ${pkgs.lynx}/bin/lynx -dump -assume_charset=%{charset} -display_charset=UTF-8 %s; copiousoutput; nametemplate=%s.html
    text/html; firefox --offline %s &; nametemplate=%s.html
  '';
  accounts.email.accounts.feishu = let
    mailboxNames = {
      Archive = "&XfJfUmhj-";
      Junk = "&V4NXPpCuTvY-";
      Trash = "&XfJSIJZk-";
      Sent = "&XfJT0ZAB-";
      Drafts = "&g0l6P3ux-";
    };
  in rec {
    primary = true;
    realName = "Tianze Zhou";
    address = "i@tianze.me";
    aliases = [ "zhou@tianze.me" ];
    imap.host = "imap.feishu.cn";
    smtp.host = "smtp.feishu.cn";
    userName = address;
    passwordCommand = "${pkgs.coreutils-full}/bin/cat ${config.home.homeDirectory}/.local/state/passwords/imap-feishu";
    mbsync = {
      enable = true;
      groups.default.channels = {
        default.extraConfig.Create = "both";
      } // builtins.mapAttrs (near: far: {
        farPattern = far;
        nearPattern = near;
        extraConfig.Create = "near";
      }) mailboxNames;
    };
    neomutt.enable = true;
    neomutt.extraMailboxes = builtins.attrNames mailboxNames;
    notmuch.enable = true;
    notmuch.neomutt.enable = true;
  };
}
