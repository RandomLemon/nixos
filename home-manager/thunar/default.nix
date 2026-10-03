{ pkgs, config, ... }:
{
  programs.thunar = {
    enable = true;
    # 可选：安装常用插件
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-media-tags-plugin
    ];
  };

  home.packages = with pkgs; [
    file-roller
  ];
}