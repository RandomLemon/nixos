{ config, ... }: {
  programs.swaylock = {
    enable = true;
    settings = {
      image = "${config.xdg.configHome}/wallpaper/wallpaper.jpg";
      scaling = "fill";

      # Slight dim so the unlock indicator stays readable on bright wallpapers.
      color = "00000060";

      "font-size" = 12;
      "indicator-radius" = 60;
      "indicator-idle-visible" = true;
      "ring-color" = "00ddff";
      "line-color" = "000000";
      "text-color" = "ffffff";
      "key-hl-color" = "000000";
      "separator-color" = "00ddff80";
      "show-failed-attempts" = true;
    };
  };
}
