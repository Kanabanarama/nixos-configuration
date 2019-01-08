{ pkgs, ... }:

{
  home.packages = [
    pkgs.lolcat
    pkgs.fortune
  ];

  programs.git = {
    enable = true;
    userName = "Kana";
    userEmail = "kanabanarama@googlemail.com";
  };

  home.file.".config/mimeapps.list" = {
     text = ''
     [Default Applications]
     image/jpeg=viewnior.desktop;
     image/png=viewnior.desktop;
     audio/mpeg=smplayer.desktop;
     text/plain=mousepad.desktop;
     '';
  };

  home.file.".config/i3/config".source = "/etc/nixos/dotfiles/small-horse-collider/kana/.config/i3/config";

  #home.path.".config/polybar".source = "/etc/nixos/dotfiles/small-horse-collider/kana/.config/polybar"; # ???
  home.file.".config/polybar/config".source = "/etc/nixos/dotfiles/small-horse-collider/kana/.config/polybar/config";
  home.file.".config/polybar/polybar-scripts/info-ssh-sessions.sh".source = "/etc/nixos/dotfiles/small-horse-collider/kana/.config/polybar/polybar-scripts/info-ssh-sessions.sh";

  home.file.".Xresources".source = "/etc/nixos/dotfiles/small-horse-collider/kana/.Xresources";

  home.file.".background-image".source = "/etc/nixos/dotfiles/small-horse-collider/kana/.background-image";
}

