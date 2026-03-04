{
  self,
  ...
}:
let
  username = "raph";
  name = "Raph";
in
{
  flake.modules.nixos.user =
    { pkgs, ... }:
    {
      users.users."${username}" = {
        isNormalUser = true;
        description = name;
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

      sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

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
