{
  services.kanata = {
    enable = true;
    keyboards.main = {
      extraDefCfg = "process-unmapped-keys yes";
      # config = ''
      #   (defsrc
      #    caps
      #   )
      #   (defvar
      #    tap-time 150
      #    hold-time 200
      #   )
      #   (defalias
      #    caps (tap-hold-press 150 200 esc lctl)
      #   )
      #
      #   (deflayer base
      #    @caps
      #   )
      # '';
      config = ''
        (defsrc
         caps
         a s d f g h j k l ;
         lmet spc
        )

        (defvar
         tap-time 150
         hold-time 200
        )

        (defalias
         caps (tap-hold-press 150 200 esc lctl)
         num (layer-toggle numbers)
         spc-num (tap-hold-press 150 200 spc @num)
        )

        (deflayer base
         @caps
         a s d f g h j k l ;
         lmet @spc-num
        )

        (deflayer numbers
         _
         1 2 3 4 5 6 7 8 9 0
         _ _
        )
      '';
    };
  };
}
