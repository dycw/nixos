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
      l = "_exa_short --git-ignore";
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

      # git: add
      ga = "git add";
      gaa = "ga -A";
      gai = "gaa -i";
      gaip = "ga -ip";
      gap = "ga -p";

      # git: add + commit
      gaac = "gaa && gc";
      gaacm = "gaa && gcm";
      gac = "git ac";
      gacm = "git acm";
      gacnv = "git acnv";
      gacnvm = "git acnvm";
      gapc = "git apc";

      # git: branch
      gb = "git branch -vv";
      gba = "gb -a";
      gbd = "gb -d";
      gbdd = "gb -D";
      gbr = "gb -r";
      gbu = "gb -u";

      # git: branch + checkout
      gdev = "g dev";

      # git: checkout
      gco = "git checkout";
      gcob = "gco -b";
      gcobmom = "gco -B master origin/master";
      gcom = "gco master";
      gcop = "gco -p";

      # git: checkout + pull
      gcoml = "gcom && gll";

      # git: checkout + pull + branch + checkout
      gredev = "gcoml && gdev";

      # git: cherry-pick
      gcp = "git cherry-pick";
      gcpa = "gcp --abort";
      gcpc = "gcp --continue";
      gcpq = "gcp --quit";
      gcps = "gcp --skip";

      # git: clone
      gcl = "git clone --recurse-submodules";

      # git: commit
      gc = "git commit";
      gcm = "gc -m";
      gcnv = "gc --no-verify";
      gcnvm = "gc --no-verify -m";

      # git: config
      gcon = "git config -l --show-origin";

      # git: diff
      gd = "git diff";
      gdc = "gd --cached";
      gdcm = "gd && gaacm";
      gdccm = "gdc && gcm";

      # git: fetch
      gf = "git fetch -p --all";

      # git: log
      gl = ''git log --format="%C(bold blue)%cd%Creset  %Cred%h%Creset  %Cgreen%d%Creset%n%s" --graph --stat'';

      # git: merge
      gm = "git merge";

      # git: mv
      gmv = "git mv";

      # git: publish
      gpb = "git pb";
      gunpb = "git unpb";

      # git: pull
      gll = "git pull";

      # git: push
      gp = "git push";
      gpdo = "gp -d origin";
      gpf = "gp -f";
      gpn = "gp -n";
      gpo = "gp origin";
      gpot = "gpo --tags";
      gpuo = "gp -u origin";

      # git: rebase
      grb = "git rebase";
      grba = "grb --abort";
      grbc = "grb --continue";
      grbi = "grb -i";
      grbm = "grb master";
      grbs = "grb --skip";

      # git: remote
      gre =  "git remote";
      gresu = "gre set-url";
      greu = "gre update";

      # git: reset
      gr = "git reset";
      grp = "gr -p";

      # git: rev-parse
      gcurrent = "git rev-parse --abbrev-ref HEAD";
      groot = "git rev-parse --show-toplevel";

      # git: revert
      grv = "git revert";

      # git: rm
      grm = "git rm";
      grmc = "grm --cached";

      # git: stash
      gst = "git stash";
      gsta = "gst apply";
      gstc = "gst clear";
      gstd = "gst drop";
      gstl = "gst list";
      gstp = "gst pop";

      # git: submodule
      gsmurr = "git submodule update --recursive --remote";

      # git: status
      gs = "git status --short";

      # git: tag
      gta = "git ta";
      gtd = "git td";

      # path
      echo-path = ''echo $PATH | sed "s/:/\n/g"'';

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
      fzf
      git
      home-manager
      hyperfine
      micro
      nox
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

      nodePackages.prettier
    ];

    variables.EDITOR = "nvim";
  };

  fonts.enableDefaultFonts = true;

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = true;
  };

  home-manager.users.derek.programs = {
    bat.enable = true;

    broot.enable = true;

    direnv = {
      enable = true;
      enableNixDirenvIntegration = true;
    };

    git = {
      aliases = {
        ac = "!f() { for v in \"$@\"; do git a \"$GIT_PREFIX$v\"; done; git c; }; f";
        acm = "!f() { i=0; for v in \"$@\"; do i=$(($i+1)); if [ $i -lt $# ]; then git a \"$GIT_PREFIX$v\"; else git cm \"$v\"; fi; done; }; f";
        acnv = "!f() { for v in \"$@\"; do git a \"$GIT_PREFIX$v\"; done; git cnv; }; f";
        acnvm = "!f() { i=0; for v in \"$@\"; do i=$(($i+1)); if [ $i -lt $# ]; then git a \"$GIT_PREFIX$v\"; else git cnvm \"$v\"; fi; done; }; f";
        apc = "!f() { for v in \"$@\"; do git ap \"$GIT_PREFIX$v\"; done; git c; }; f";
        dev = "(gbdd dev || true) && gcob dev";
        pb = "!gpuo $(gcurrent) && :";
        ta = "!git tag -a \"$1\" \"$2\" -m \"$1\" && :";
        td = "!git tag --delete \"$1\" && :";
        unpb = "!gbr --color=never | fzf | sed -En 's/origin\\/(.*)/\\1/p' | xargs -n 1 gpdo";
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

        core.eol = "lf";

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
        set pastetoggle=<F2>

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
        set nosmarttab
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

        " mappings: shift blocks visually
        vnoremap > >gv
        vnoremap < <gv

        " mappings: substitute
        vnoremap s :s/
        vnoremap <C-r> "hy:,$s/<C-r>h//gc<Left><Left><Left>

        " mappings: windows
        nnoremap <C-w>h     :set nosplitright<Bar>:vsplit<Bar>:set splitright<CR>
        nmap     <C-w><C-h> <C-w>h
        nnoremap <C-w>j     :split<CR>
        nmap     <C-w><C-j> <C-w>j
        nnoremap <C-w>k     :set nosplitbelow<Bar>:split<Bar>:set splitbelow<CR>
        nmap     <C-w><C-k> <C-w>k
        nnoremap <C-w>l     :vsplit<CR>
        nmap     <C-w><C-l> <C-w>l
        nnoremap <C-h>      <C-w>h
        nnoremap <C-j>      <C-w><C-w>
        nnoremap <C-k>      <C-w>W
        nnoremap <C-l>      <C-w>l
        nnoremap <C-w><C-w> <C-w>p

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

        vim-tmux-navigator
      ];

      viAlias = true;

      vimAlias = true;

      vimdiffAlias = true;

      withNodeJs = true;
    };

    pet.enable = true;

    qutebrowser.enable = true;

    rofi.enable = true;

    starship.enable = true;

    tmux = {
      enable = true;
      extraConfig = ''
        # server
        set -g default-terminal "screen-256color"
        set -g escape-time 1
        set -g focus-events on
        set -g history-limit 100000

        # session
        set -g base-index 1
        set -g bell-action none
        set -g display-panes-active-colour white
        set -g display-panes-colour white
        set -g display-panes-time 2000
        set -g mouse on
        set -g renumber-windows on
        set -g repeat-time 250
        set -g visual-activity off
        set -g visual-bell off
        set -g visual-silence off

        # session: status
        set -g status on
        set -g status-interval 1
        set -g status-justify left
        set -g status-keys vi
        set -g status-left ""
        set -g status-left-length 0
        set -g status-position bottom
        set -g status-right "#(TZ=Asia/Hong_Kong date \"+%%Y-%%m-%%d %%H:%%M:%%S (%%a)\")"
        set -g status-right-length 25
        set -g status-style "bg=black"

        # window: pane
        set -g allow-rename off
        set -g clock-mode-style 12
        set -g main-pane-height 12
        set -g mode-keys vi
        set -g pane-active-border-style "fg=blue,bold,bg=default"
        set -g pane-base-index 1
        set -g pane-border-format ""
        set -g pane-border-status top
        set -g pane-border-style "fg=blue,bold,bg=default"
        set -g window-active-style "fg=default,bg=default"
        set -g window-size largest
        set -g window-status-current-style "fg=default,bg=default"
        set -g window-status-style "fg=default,bg=default"
        set -g window-status-separator ""

        # window status
        set -g window-status-format ' #[fg=white,bold]#{window_index} #(echo "#{pane_current_path}" | rev | cut -d'/' -f-1 | rev)#([ #{window_zoomed_flag} -eq 1 ] && echo " <Z>" || echo "") #[default]'
        set -g window-status-current-format '#[fg=white,bold,bg=blue,bold] #{window_index} #(echo "#{pane_current_path}" | rev | cut -d'/' -f-1 | rev)#([ #{window_zoomed_flag} -eq 1 ] && echo " <Z>" || echo "") #[default]'

        # pane styles
        set -g window-style "fg=default,bg=default"

        # bindings: prefix
        unbind C-b
        set -g prefix `
        bind ` send-prefix

        # bindings: reload
        bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
      '';
      plugins = with pkgs; [
        tmuxPlugins.cpu
        tmuxPlugins.vim-tmux-navigator
      ];
    };

    zathura.enable = true;

    zoxide.enable = true;
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

  nix = {
    gc.automatic = true;
    optimise.automatic = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    bandwhich.enable = true;

    fish = {
      enable = true;
    };

    nano.nanorc = ''
      set nowrap
      set tabstospaces
      set tabsize 2
    '';
  };

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

  system = {
    autoUpgrade = {
      allowReboot = true;
      enable = true;
    };
    stateVersion = "20.09";
  };

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

  users = {
    defaultUserShell = pkgs.fish;
    users.derek = {
      description = "Derek Wan";
      extraGroups = [ "wheel" ];
      isNormalUser = true;
      shell = pkgs.fish;
    };
  };
}
