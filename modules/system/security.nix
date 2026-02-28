{
  flake.modules.nixos.security = {
    security = {
      polkit.enable = true;
      rtkit.enable = true;
    };
  };
}
