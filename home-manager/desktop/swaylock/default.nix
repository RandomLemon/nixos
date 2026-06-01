{ config, ... }: {
  programs.swaylock = {
    enable = true;
    settings = {
      image = "${config.xdg.configHome}/wallpaper/wallpaper.jpg";
      scaling = "fill";

      # Slight dim so the unlock indicator stays readable on bright wallpapers.
      color = "00000066";

      "font-size" = 24;
      "indicator-radius" = 120;
      "indicator-idle-visible" = true;
      "ring-color" = "00ddff";
      "line-color" = "00ddff";
      "text-color" = "ffffff";
      "key-hl-color" = "00ddff";
      "separator-color" = "00ddff80";
      "show-failed-attempts" = true;
    };
  };
}
