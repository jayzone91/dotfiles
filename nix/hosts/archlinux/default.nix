{
  ...
}:

{
  imports = [
    ../../modules/common
    ../../modules/shell
    ../../modules/desktop
  ];

  home.username = "jay";
  home.homeDirectory = "/home/jay";

  # Dieser Wert bleibt nach der ersten Aktivierung grundsätzlich bestehen.
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  # Ein zunächst ungefährlicher Test:
  # Home Manager legt ~/.config/nix-managed-test an.
  home.file.".config/nix-managed-test".text = ''
    Diese Datei wird durch Home Manager verwaltet.
  '';
}
