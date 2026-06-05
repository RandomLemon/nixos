{ pkgs, ... }: {
  services.swayidle = {
    enable = true;

    events = {
      # Lock before suspend/hibernate (systemctl suspend, lid close, etc.)
      before-sleep = "${pkgs.swaylock}/bin/swaylock -fF";
    };
  };
}
