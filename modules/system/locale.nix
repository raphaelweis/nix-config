{
  flake.modules.nixos.locale = {
    time.timeZone = "Europe/Paris";

    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocales = [ "fr_FR.UTF-8/UTF-8" ];

      inputMethod = {
        enable = true;
        type = "ibus";
      };
    };
  };
}
