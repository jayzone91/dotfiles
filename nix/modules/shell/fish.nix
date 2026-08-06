{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Doppelte PATH-Einträge entfernen, Reihenfolge beibehalten.
      set -l unique_path

      for path_entry in $PATH
      if not contains -- $path_entry $unique_path
      set -a unique_path $path_entry
      end
      end

      set -gx PATH $unique_path

      set -g fish_key_bindings fish_default_key_bindings
      set -g fish_history main

      set -g fish_color_command green
      set -g fish_color_param text
      set -g fish_color_quote yellow
      set -g fish_color_redirection peach
      set -g fish_color_end blue
      set -g fish_color_error red
      set -g fish_color_comment overlay0
      set -g fish_color_selection --background=surface1
      set -g fish_color_search_match --background=surface0
      set -g fish_color_operator mauve
      set -g fish_color_escape pink
      set -g fish_color_autosuggestion overlay0

      set -gx NVM_DIR "$HOME/.nvm"

      if test -s /usr/share/nvm/init-nvm.sh
      if type -q bass
      bass source /usr/share/nvm/init-nvm.sh --no-use
      nvm use default >/dev/null 2>&1
      end
      end
    '';
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
