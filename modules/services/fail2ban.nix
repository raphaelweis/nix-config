{
  flake.modules.nixos.fail2ban-server = {
    services.fail2ban.enable = true;
  };
}
