{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        pgadmin4
        jetbrains.datagrip
      ];
    };
  };
}
