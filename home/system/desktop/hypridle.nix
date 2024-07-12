{pkgs, ...}: {
  home.packages = with pkgs; [brightnessctl];
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        ignore_dbus_inhibit = false;
      };
      listener = [
        # 2.5 min
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        # 5 min
        {
          timeout = 300;
          on-timeout = "loginctl lock-session"; # Command defined above
        }
        # 5 min and 30 sec
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
