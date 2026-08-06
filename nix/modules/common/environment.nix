{
  home.sessionPath = [
    "$HOME/.bun/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";

    PAGER = "less";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";

    BAT_THEME = "Catppuccin Mocha";

    FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git";
    FZF_CTRL_T_COMMAND = "fd --type f --hidden --follow --exclude .git";
  };
}
