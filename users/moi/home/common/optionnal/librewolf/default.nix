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
      "browser.policies.runOncePerModification.extensionsInstall" = ''
        ["https://addons.mozilla.org/firefox/downloads/file/3954735/black21-3.0.2.xpi","https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"]
      '';
    };
  };
}
