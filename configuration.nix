{ config, pkgs, ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/nix-community/home-manager.git";
    rev = "209566c752c4428c7692c134731971193f06b37c";
    ref = "release-20.09";
  };
in
{
  imports =
    [
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  boot = {
    cleanTmpDir = true;

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  documentation.man.generateCaches = true;

  environment = {
    shellAliases = {
      # bat
      cat = "bat";

      # cd
      cddf = "cd ~/dotfiles";
      cddl = "cd ~/Downloads";
      cdw = "cd ~/work";

      # exa
      _exa_base = "exa --classify --group-directories-first";
      _exa_short = "_exa_base --across";
      l=" _ exa_short --git-ignore";
      la = "_exa_short --all";
      _exa_long = "_exa_base --git --group --header --long --time-style=long-iso";
      ll = "_exa_long --git-ignore";
      lla = "_exa_long --all";
      lal = "lla";

      # fd
      fd = "fd -H";
      fdd = "fd -t=d";
      fde = "fd -t=e";
      fdf = "fd -t=f";
      fds = "fd -t=s";

      # git
      gaac = "gaa && gc";
      gap = "gapa";
      gcd = "gco develop 2>/dev/null || gcb develop";
      gcm = "gcmsg";
      gcom = "git checkout $(git_main_branch)";
      gcop = "gco -p";
      gdm = "gd && gaa && gcm";
      gdc = "gdca";
      gdcm = "gdca && gcm";
      gl = "git log --format=\"%C(bold blue)%cd%Creset  %Cred%h%Creset  %Cgreen%d%Creset%n%s\" --graph --stat";
      gll = "glgp";
      gpl = "git pull";
      gs = "gss";

      # path
      echo-path = "echo $PATH | sed \"s/:/\n/g\"";

      # spotify
      spotify = "nohup spotify &";

      # vim
      v = "vim";
    };

    systemPackages = with pkgs; [
      curl
      diskonaut
      dropbox-cli
      exa
      fd
      geany
      git
      home-manager
      hyperfine
      micro
      nodePackages.prettier
      nox
      oh-my-zsh
      pdfarranger
      pipenv
      ripgrep
      shellcheck
      shfmt
      signal-desktop
      spotify
      tealdeer
      tokei
      vim
      watchexec
      wget
      zsh
    ];

    variables.EDITOR = "nvim";
  };

  hardware.pulseaudio.enable = true;

  home-manager.users.derek.programs = {
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
        " settings: casing
        set ignorecase
        set smartcase

        " settings: line numbers
        set number
        set relativenumber

        " settings: pasting
        set pastetoggle=<F11>

        " settings: read files automatically
        set autoread

        " settings: scrolling
        set scrolloff=5
        set sidescrolloff=5

        " settings: substitute globally
        set gdefault

        " settings: spaces and tabs
        set list
        set expandtab
        set shiftwidth=2
        set softtabstop=2
        set tabstop=2

        " settings: tab pages
        set showtabline=2

        " mappings: leader
        let mapleader=' '

        " mappings: clear search highlights
        nnoremap <Esc> :nohlsearch<return><Esc>

        " mappings: command mode
        nnoremap ; :
        vnoremap ; :

        " mappings: ex mode disabled
        noremap Q <Nop>

        " mappings: normal mode
        imap jk <Esc>
        imap kj <Esc>

        " mappings: save
        nnoremap <C-s> :w<CR>
        inoremap <C-s> <Esc>:w<CR>
        vnoremap <C-s> <Esc>:w<CR>

        " mappings: shift blocks visually (https://bit.ly/3tSsA9N)
        vnoremap > >gv
        vnoremap < <gv

        " mappings: quit
        nnoremap <C-q> :q<CR>
      '';

      extraPython3Packages = (ps: with ps; [ python-language-server ]);

      plugins = with pkgs.vimPlugins; [
        ale

        {
          plugin = fzf-vim;
          config = ''
            nnoremap <Leader>b :Buffers<CR>
            nnoremap <Leader>c :Commands<CR>
            nnoremap <Leader>C :History<CR>
            nnoremap <Leader>f :GFiles<CR>
            nnoremap <Leader>F :Files<CR>
            nnoremap <Leader>h :History<CR>
            nnoremap <Leader>H :Helptags!<CR>
            nnoremap <Leader>m :Marks<CR>
            nnoremap <Leader>M :Maps<CR>
            nnoremap <Leader>l :Rg<CR>
            nnoremap <Leader>L :BLines<CR>
            nnoremap <Leader>t :Tags<CR>
            nnoremap <Leader>T :BTags<CR>
            nnoremap <Leader>w :Windows<CR>
          '';
        }

        {
          plugin = fugitive;
          config = ''
            nnoremap <Leader>ga :Git add %:p<CR>
            nnoremap <Leader>gc :Gcommit<CR>
            nnoremap <Leader>gd :Gdiff<CR>
            nnoremap <Leader>gs :Gstatus<CR>
            nnoremap <Leader>gp :Gpush<CR>
          '';
        }

        vim-airline

        vim-devicons

        vim-eunuch

        vim-lastplace

        vim-nix

        vim-repeat

        vim-sensible

        {
          plugin = vim-signify;
          config = ''
            highlight SignifySignAdd    ctermfg=green  guifg=#00ff00 cterm=NONE gui=NONE
            highlight SignifySignDelete ctermfg=red    guifg=#ff0000 cterm=NONE gui=NONE
            highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE
          '';
        }

        vim-speeddating

        {
          plugin = vim-startify;
          config = ''
            let g:startify_lists = [
              \ { 'type': 'dir',       'header': ['MRU '. getcwd()] },
              \ { 'type': 'files',     'header': ['MRU']            },
              \ { 'type': 'sessions',  'header': ['Sessions']       },
              \ { 'type': 'bookmarks', 'header': ['Bookmarks']      },
              \ { 'type': 'commands',  'header': ['Commands']       },
              \ ]
            let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
            let g:ascii = []
            let g:startify_custom_header = ['Hello, Derek']
          '';
        }

        vim-surround
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
  };

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "nixos";

    useDHCP = false;

    interfaces = {
      eno1.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  services = {
    lorri.enable = true;

    openssh.enable = true;

    printing.enable = true;

    xserver = {
      desktopManager.gnome3.enable = true;
      displayManager.gdm.enable = true;
      enable = true;
    };
  };

  sound.enable = true;

  system.stateVersion = "20.09";

  systemd.user.services.dropbox = {
    after = [ "xembedsniproxy.service" ];

    description = "Dropbox";

    environment = {
      QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
    };

    serviceConfig = {
      ExecStart = "${pkgs.dropbox.out}/bin/dropbox";
      ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
      KillMode = "control-group"; # upstream recommends process
      Nice = 10;
      PrivateTmp = true;
      ProtectSystem = "full";
      Restart = "on-failure";
    };

    wants = [ "xembedsniproxy.service" ];

    wantedBy = [ "graphical-session.target" ];
  };

  time.timeZone = "Asia/Hong_Kong";

  users.users.derek = {
    description = "Derek Wan";
    home = "/home/derek";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = ''
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

    # Customize your oh-my-zsh options here
    ZSH_THEME="robbyrussell"
    plugins=(
      alias-finder
      direnv
      fd
      git
      git-auto-fetch
      ripgrep
      tmux
      vi-mode
      zsh-interactive-cd
      zsh_reload
    )

    bindkey '\e[5~' history-beginning-search-backward
    bindkey '\e[6~' history-beginning-search-forward

    HISTFILESIZE=500000
    HISTSIZE=500000
    setopt SHARE_HISTORY
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_IGNORE_DUPS
    setopt INC_APPEND_HISTORY
    autoload -U compinit && compinit
    unsetopt menu_complete
    setopt completealiases

    if [ -f ~/.aliases ]; then
      source ~/.aliases
    fi

    source $ZSH/oh-my-zsh.sh
  '';
  programs.zsh.promptInit = "";


}
