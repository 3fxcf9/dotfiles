# Batsignal is a simple utility to send battery notifications.
{
  services.batsignal = {
    enable = true;
    extraArgs = ["-c 5" "-w 20" "-f disabled"];
  };
}
