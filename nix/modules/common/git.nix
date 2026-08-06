{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "jayzone91";
        email = "register@j4yz0n3.de";
      };

      init.defaultBranch = "main";

      fetch = {
        prune = true;
        pruneTags = true;
      };

      push.autoSetupRemote = true;

      core.editor = "nvim";
      color.ui = "auto";

      rerere.enabled = true;
      merge.conflictStyle = "zdiff3";
      pull.rebase = true;

      credential = {
        "https://github.com".helper = [
          ""
          "!gh auth git-credential"
        ];

        "https://gist.github.com".helper = [
          ""
          "!gh auth git-credential"
        ];
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;

    options = {
      navigate = true;
      side-by-side = true;
      line-numbers = true;
      syntax-theme = "Catppuccin Mocha";
    };
  };
}
