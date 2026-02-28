{
  self,
  ...
}:
let
  username = "raphaelw";
in
{
  flake.modules.nixos.user =
    { pkgs, ... }:
    {
      users.users."${username}" = {
        isNormalUser = true;
        home = "/home/${username}";
        extraGroups = [
          "wheel"
          "input"
          "video"
          "kvm"
          "adbusers"
          "docker"
          "libvirtd"
          "networkmanager"
        ];
        shell = pkgs.zsh;
      };
      programs.zsh.enable = true;

      home-manager.users."${username}" = {
        imports = [
          self.modules.homeManager.user
        ];
        programs.home-manager.enable = true;
      };
    };

  flake.modules.homeManager.user = {
    home = {
      homeDirectory = "/home/${username}";
    };
  };
}
