if status is-interactive
    # Commands to run in interactive sessions can go here
    set -q fish_greeting
    
    #prompt
    starship init fish | source


    # schneller verzeichniswechsel
    zoxide init fish | source

    # fzf integration
    fzf --fish | source


    # Path
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/go/bin
    fish_add_path $HOME/.bun/bin

    # editor
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx SUDO_EDITOR nvim

    # default tools
    set -gx PAGER less
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

    set -gx BAT_THEME = "Catppuccin Mocha"

    # abbr
    abbr -a cd "z"
    abbr -a ls "eza --icons --group-directories-first"
    abbr -a ll "eza -lah --icons --group-directories-first"
    abbr -a la "eza -a --icons --group-directories-first"
    abbr -a lt "eza --tree --icons --group-directories-first"

    abbr -a cat "bat"
    abbr -a grep "rg"
    abbr -a find "fd"

    abbr -a c "clear"
    abbr -a cls "clear"

    abbr -a .. "cd .."
    abbr -a ... "cd ../.."
    abbr -a .... "cd ../../.."

    abbr -a gs "git status"
    abbr -a ga "git add"
    abbr -a gaa "git add --all"
    abbr -a gc "git commit"
    abbr -a gcm "git commit -mm"
    abbr -a gp "git push"
    abbr -a gl "git pull"
    abbr -a gd "git diff"
    abbr -a gb "git branch"
    abbr -a gco "git checkout"
    abbr -a gsw "git switch"
    abbr -a glog "git log --oneline --graph --decorate --all"

    abbr -a update "paru -Syu"
    abbr -a cleanup "pary -Sc"

    abbr -a reloadfish "source ~/.config/fish/conig.fish"

    # FZF
    set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

    set -gx FZF_DEFAULT_OPTS "
    	--height=40%
	--layout=reverse
	--border
	--info=inline
	--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
	--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
	--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
	"

    # nvm
    set -gx NVM_DIR "$HOME/.nvm"

    if test -s /usr/share/nvm/init-nvm.sh
	    bass source /usr/share/nvm/init-nvm.sh --no-use
    end

    # fish behaviour
    set -g fish_key_bindings fish_default_key_bindings

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

    # History
    set -g fish_history main
end
