{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    bat
    eza
    fd
    ripgrep
    fzf
    zoxide
    lazygit
    fastfetch
  ];
}
