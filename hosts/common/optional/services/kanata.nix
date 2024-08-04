{
  services.kanata = {
    enable = true;
    keyboards.main = {
      extraDefCfg = "process-unmapped-keys yes";
      config = ''
        (defsrc
         caps
        )
        (defvar
         tap-time 150
         hold-time 200
        )
        (defalias
         caps (tap-hold-press 150 200 esc lctl)
        )

        (deflayer base
         @caps
        )
      '';
    };
  };
}
