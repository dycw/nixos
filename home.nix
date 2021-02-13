{ config, pkgs, ... }:

{
  home = {
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "21.03";

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    homeDirectory = "/home/derek";
    username = "derek";
  };

  programs = {
    bat.enable = true;

    broot = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      enableNixDirenvIntegration = true;
      enableZshIntegration = true;
    };

    git = {
      aliases = {
        current = "rev-parse --abbrev-ref HEAD";
        publish = "!git push --set-upstream origin $(git current) && :";
        unpublish = "!git branch -r --color=never | fzf | sed -En 's/origin\\/(.*)/\\1/p' | xargs -n 1 git push --delete origin";
        root = "rev-parse --show-toplevel";
      };

      delta = {
        enable = true;
        options = {
          features = "side-by-side line-numbers decorations";
          minus-style = "Syntax \"#3f0001\"";
          plus-style = "Syntax \"#003800\"";
          syntax-theme = "Dracula";
          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-style = "bold yellow ul";
            file-decoration-style = "none";
            hunk-header-decoration-style = "cyan box ul";
          };
          line-numbers = {
            line-numbers-left-style = "cyan";
            line-numbers-right-style = "cyan";
            line-numbers-minus-style = 124;
            line-numbers-plus-style = 28;
          };
        };
      };

      enable = true;

      extraConfig = {
        branch = {
          autoSetupMerge = "always";
          autoSetupRebase = "always";
        };

        checkout.defaultRemote = "origin";

        commit.verbose = true;

        color.ui = "always";

        core = {
          editor = "vim";
          eol = "lf";
        };

        diff = {
          colorMoved = true;
          statGraphWidth = 10;
        };

        fetch = {
          prune = true;
          pruneTags = true;
        };

        help.autoCorrect = 1;

        log = {
          abbrevCommit = true;
          date = "format:%Y-%m-%d %H:%M:%S (%a)";
        };

        merge = {
          conflictStyle = "diff3";
          ff = "only";
        };

        pull.ff = "only";

        push = {
          default = "simple";
          followTags = true;
        };

        rebase = {
          abbreviateCommands = true;
          autoSquash = true;
          stat = true;
        };

        status.branch = true;

        tag.sort = "version:refname";

        user.useConfigOnly = true;
      };

      includes = [ { path = "~/.config/git/config.local"; } ];

      ignores = [ "nohup.out" ];

      userEmail = "d.wan@icloud.com";

      userName = "Derek Wan";
    };

    firefox.enable = true;

    fzf = {
      changeDirWidgetCommand = "fd -H -t=d";
      changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
      defaultCommand = "fd -H -t=f";
      defaultOptions = [ "--border" "--height 40%" ];
      enable = true;
      enableZshIntegration = true;
      fileWidgetCommand = "fd -H -t=f";
      fileWidgetOptions = [ "--preview 'head {}'" ];
      historyWidgetOptions = [ "--exact" "--sort" ];
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    htop = {
      enable = true;
      enableMouse = true;
    };

    lf.enable = true;

    lsd.enable = true;

    # https://github.com/NixOS/nixpkgs/issues/98166#issuecomment-725319238
    neovim = {
      enable = true;

      extraConfig = ''
        " settings
        set list
        set expandtab
        set number
        set ignorecase
        set relativenumber
        set shiftwidth=2
        set softtabstop=2
        set tabstop=2
        " mappings
        let mapleader=' '
        " disable Ex mode
        noremap Q <Nop>
        " command mode
        nnoremap ; :
        " normal mode
        imap jk <Esc>
        imap kj <Esc>
        " save
        nnoremap <C-s> :w<CR>
        inoremap <C-s> <Esc>:w<CR>
        vnoremap <C-s> <Esc>:w<CR>
        " quit
        nnoremap <C-q> :q<CR>
      '';

      extraPython3Packages = (ps: with ps; [ python-language-server ]);

      plugins = with pkgs.vimPlugins; [
        ale

        vim-airline

        vim-devicons

        vim-nix

        vim-startify
      ];

      viAlias = true;

      vimAlias = true;

      vimdiffAlias = true;

      withNodeJs = true;
    };

    pet.enable = true;

    qutebrowser.enable = true;

    rofi.enable = true;

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    tmux = {
      aggressiveResize = true;
      baseIndex = 1;
      disableConfirmationPrompt = true;
      enable = true;
      extraConfig = ''
        bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
        set  -g mouse on
        set  -g renumber-windows on
        set  -g status-interval 1
        set  -g status-left ""
        set  -g status-right "#(TZ=Asia/Hong_Kong date \"+%%Y-%%m-%%d %%H:%%M:%%S (%%a)\")"
        setw -g window-status-format ' #[fg=white,bold]#{window_index} #(echo "#{pane_current_path}" | rev | cut -d'/' -f-1 | rev)#([ #{window_zoomed_flag} -eq 1  ] && echo " <Z>" || echo "") #[default]'
        setw -g window-status-current-format '#[fg=white,bold,bg=blue,bold] #{window_index} #(echo "#{pane_current_path}" | rev | cut -d'/' -f-1 | rev)#([ #{window_zoomed_flag} -eq 1  ] && echo " <Z>" || echo "") #[default]'
      '';
      historyLimit = 20000;
      keyMode = "vi";
      plugins = with pkgs; [ tmuxPlugins.cpu ];
      newSession = true;
      shortcut = "a";
      terminal = "screen-256color";
    };

    zathura.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;

      enableAutosuggestions = true;

      autocd = true;

      defaultKeymap = "viins";

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        # path = "${config.xdg.dataHome}/zsh/zsh_history";
        save = 100000;
        size = 100000;
      };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "alias-finder"
          "direnv"
          "fd"
          "git"
          "git-auto-fetch"
          "ripgrep"
          "tmux"
          "vi-mode"
          "zsh-interactive-cd"
          "zsh_reload"
        ];
        theme = "bobbyrussell";
      };

      shellAliases = {
        cat = "${pkgs.bat}/bin/bat";
      };
    };
  };
}
