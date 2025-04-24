{
  services.kanata = {
    enable = true;
    keyboards.main = {
      extraDefCfg = "process-unmapped-keys yes";
      #       (defsrc
      #   u i o p [   ;; Shifted right
      #   caps a s d f g h j k l ;
      #   b n
      #   lalt c XF86Assistant
      # )
      # (defvar
      #   tap-time 150
      #   hold-time 200
      # )
      #
      # (defalias
      #   a (tap-hold $tap-time $hold-time a lalt)
      #   s (tap-hold $tap-time $hold-time s lmet)
      #   d (tap-hold $tap-time $hold-time d lsft)
      #   f (tap-hold $tap-time $hold-time f lctl)
      #   j (tap-hold $tap-time $hold-time j lctl)
      #   k (tap-hold $tap-time $hold-time k lsft)
      #   l (tap-hold $tap-time $hold-time l lmet)
      #   ; (tap-hold $tap-time $hold-time ; lalt)
      #   ralt-num (layer-toggle number-row)
      #
      #   c (fork tab c (lalt lmet lsft lctl rctl rsft rmet ralt))
      # )
      #
      # (deflayer base
      #   j m d o y
      #   esc @a @s @d @f _ _ @j @k @l @;
      #   @ralt-num @c lsft
      # )
      #
      # (deflayer number-row
      #   _  1  2  3  4  5  6  7  8  9  0
      #   _ _ _
      # )

      config = ''
        (defsrc
          u i o p [
          caps a s d f g h j k l ; ' \
          m , . / rsft
          lalt c
        )

        (defvar
          tap-time 150
          hold-time 200
        )

        (defalias
          a (tap-hold $tap-time $hold-time a lalt)
          s (tap-hold $tap-time $hold-time s lmet)
          d (tap-hold $tap-time $hold-time d lsft)
          f (tap-hold $tap-time $hold-time f lctl)

          j (tap-hold $tap-time $hold-time j lctl)
          k (tap-hold $tap-time $hold-time k lsft)
          l (tap-hold $tap-time $hold-time l lmet)
          ; (tap-hold $tap-time $hold-time ; lalt)

          ralt-num (layer-toggle number-row)

          c (fork tab c (lalt lmet lsft lctl rctl rsft rmet ralt))
        )

        (deflayer base
          y u i o p
          esc @a @s @d @f _ _ h @j @k @l @; '
          n m , . /
          @ralt-num @c
        )

        (deflayer number-row
          _ _ _ _ _
          _ 1 2 3 4 5 _ 6 7 8 9 0 _
          _ _ _ _ _
          _ _
        )
      '';

      # config = ''
      #   (defsrc
      #     u i o p [
      #     caps a s d f g h j k l ; ' \
      #     m , . / rsft
      #     lalt c f23
      #   )
      #
      #   (defvar
      #     tap-time 150
      #     hold-time 200
      #   )
      #
      #   (defalias
      #     a (tap-hold $tap-time $hold-time a lalt)
      #     s (tap-hold $tap-time $hold-time s lmet)
      #     d (tap-hold $tap-time $hold-time d lsft)
      #     f (tap-hold $tap-time $hold-time f lctl)
      #
      #     j (tap-hold $tap-time $hold-time j lctl)
      #     k (tap-hold $tap-time $hold-time k lsft)
      #     l (tap-hold $tap-time $hold-time l lmet)
      #     ; (tap-hold $tap-time $hold-time ; lalt)
      #
      #     ralt-num (layer-toggle number-row)
      #
      #     c (fork tab c (lalt lmet lsft lctl rctl rsft rmet ralt))
      #
      #     copilot-key (meta shift f23)
      #   )
      #
      #   (deflayer base
      #     y u i o p
      #     esc @a @s @d @f _ _ h @j @k @l @; '
      #     n m , . /
      #     @ralt-num @c
      #     copilot-key -> lsft
      #   )
      #
      #   (deflayer number-row
      #     _ _ _ _ _
      #     _ 1 2 3 4 5 _ 6 7 8 9 0 _
      #     _ _ _ _ _
      #     _ _ _
      #   )
      # '';
      # config = ''
      #   (defsrc
      #    caps
      #    a s d f g h j k l ;
      #    lmet spc
      #   )
      #
      #   (defvar
      #    tap-time 150
      #    hold-time 200
      #   )
      #
      #   (defalias
      #    caps (tap-hold-press 150 200 esc lctl)
      #    num (layer-toggle numbers)
      #    spc-num (tap-hold-press 150 200 spc @num)
      #   )
      #
      #   (deflayer base
      #    @caps
      #    a s d f g h j k l ;
      #    lmet @spc-num
      #   )
      #
      #   (deflayer numbers
      #    _
      #    1 2 3 4 5 6 7 8 9 0
      #    _ _
      #   )
      # '';
    };
  };
}
