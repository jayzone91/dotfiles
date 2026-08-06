{
  programs.fish.shellAbbrs = {
    cd = "z";

    ls = "eza --icons --group-directories-first";
    ll = "eza -lah --icons --group-directories-first";
    la = "eza -a --icons --group-directories-first";
    lt = "eza --tree --icons --group-directories-first";

    cat = "bat";
    grep = "rg";
    find = "fd";

    c = "clear";
    cls = "clear";

    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";

    gs = "git status";
    ga = "git add";
    gaa = "git add --all";
    gc = "git commit";
    gcm = "git commit -m";
    gp = "git push";
    gl = "git pull";
    gd = "git diff";
    gb = "git branch";
    gco = "git checkout";
    gsw = "git switch";
    glog = "git log --oneline --graph --decorate --all";

    update = "paru -Syu";
    cleanup = "paru -Sc";

    reloadfish = "exec fish";

    hms = "home-manager switch --flake /data/Projects/dotfiles#jay";
    hmc = "nix flake check /data/Projects/dotfiles";
    hmu = "nix flake update /data/Projects/dotfiles";
  };
}
