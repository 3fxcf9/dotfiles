{...}: {
  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.resistFingerprinting" = false;
      "browser.ctrlTab.sortByRecentlyUsed" = true;
      "browser.tabs.warnOnClose" = true;
      "dom.forms.autocomplete.formautofill" = false;
      "general.autoScroll" = true;
      "network.captive-portal-service.enabled" = true;
      "privacy.donottrackheader.enabled" = true;
      "signon.management.page.breach-alerts.enabled" = false;
      "places.history.enabled" = false;
      "browser.translations.enable" = false;

      # Dark theme
      # TODO: Consistent theme
      "layout.css.prefers-color-scheme.content-override" = 0;
      "browser.theme.content-theme" = 0;
      "browser.theme.toolbar-theme" = 0;
    };
  };
}
