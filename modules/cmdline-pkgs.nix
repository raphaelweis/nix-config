{
  flake.modules.nixos.cmdline-pkgs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        vim
      ];
    };

  flake.modules.homeManager.cmdline-pkgs =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        killall
        home-manager
        xclip
        ripgrep
        fd
        gcc
        nodejs
        pnpm
        rlwrap
        chntpw
        acpi
        google-cloud-sdk
        sops
        age
        typst
        file
        jq
        gnumake
        tree
      ];
    };
}
