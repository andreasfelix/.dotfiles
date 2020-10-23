{
  allowUnfree = true;
  # # disabled while testing home-manager
  # packageOverrides = pkgs: with pkgs; {
  #   all = buildEnv {
  #     name = "all";
  #     paths = [
  #       # list of programs
  #     ];
  #   };
  # };
}
