{username, pkgs,  ...}: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };
  programs.home-manager.enable = true;

  # USB devices
  services.udiskie = {
    enable = true;
    settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
            # replace with your favorite file manager
            file_manager = "${pkgs.nautilus}/bin/nautilus";
        };
    };
  };

  # Secure
  services.gnome-keyring.enable = true;
  home.packages = [ pkgs.gcr ];

  # Theme
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
