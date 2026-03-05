{
  flake.modules.nixos.steam =
    { pkgs, ... }:
    {
      programs = {
        steam.enable = true;
        gamemode.enable = true;
      };
      environment.systemPackages = with pkgs; [
        steam-run
      ];
    };
}
