{
  flake.modules.nixos.spotify =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ spotify ];
    };
}
