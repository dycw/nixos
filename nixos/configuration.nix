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

	boot.loader = {
		efi.canTouchEfiVariables = true;
		systemd-boot.enable = true;
	};

	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};

	environment.systemPackages = with pkgs; [
		curl
		diskonaut
		dropbox-cli
		exa
		fd
		fzf
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
		zoxide
		zsh
	];

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

		tmux = {
			aggressiveResize = true;
			baseIndex = 1;
			disableConfirmationPrompt = true;
			enable = true;
			extraConfig = ''
				bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
				set  -g status-interval 1
				set  -g status-left ""
				set  -g status-right "#(TZ=Asia/Hong_Kong date \"+%%Y-%%m-%%d %%H:%%M:%%S (%%a)\")"
				setw -g window-status-format ' #[fg=white,bold]#{window_index} #(echo "#{pane_current_path}" | rev | cut -d'/' -f-1 | rev)#([ #{window_zoomed_flag} -eq 1  ] && echo " <Z>" || echo "") #[default]'
				setw -g window-status-current-format '#[fg=white,bold,bg=blue,bold] #{window_index} #(echo "#{pane_current_path}" | rev | cut -d'/' -f-1 | rev)#([ #{window_zoomed_flag} -eq 1	] && echo " <Z>" || echo "") #[default]'
			'';
			historyLimit = 20000;
			keyMode = "vi";
			plugins = with pkgs; [ tmuxPlugins.cpu ];
			newSession = true;
			shortcut = "a";
			terminal = "screen-256color";
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
