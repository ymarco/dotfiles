{pkgs, lib, ...}:
let
  nixos-unstable = import <nixos-unstable> { };
  nixos-stable = import <nixos> { };
in {
  home.packages = with pkgs; [
    htop xst hyperfine ghostscript pandoc youtube-dl
    xkblayout-state ffmpeg peek maim vlc dragon-drop skim zip slop neofetch
    mpc_cli feh  transmission-gtk calibre acpilight sxiv slop pdf2svg
    libnotify lsof ncdu beets mpd mpv lf gimp  poppler_utils rsync

    # disabled in favor of the native package manager
    # rofi evince
    nixos-unstable.inkscape # inkscape 1.0
    # TODO keep?
    nixos-unstable.keepassxc thunderbird birdtray

    gcc # so I can compile the damned emacsql-sqlite

    # convert MS Excel xlsx to csv and other data tools
    gnumeric xsv

    # Doom dependencies
    xclip fd ripgrep imagemagick aspell aspellDicts.en aspellDicts.en-computers
    aspellDicts.en-science aspellDicts.he # stylelint
    # org roam
    sqlite graphviz
    # cc
    ccls
    # javascript
    nodePackages.javascript-typescript-langserver
    nodePackages.js-beautify
    nodePackages.prettier
    html-tidy
    # json
    jq
    # shell
    shellcheck
    # nix
    nixfmt
    # lexic
    sdcv html-xml-utils xmlstarlet

    # python
    #python37Packages.black # FIXME
    python37Packages.python-language-server
    #python37Packages.pyls-black
    python37Packages.pyls-isort
    # TODO
    (python3.withPackages (ps: with ps; [numpy pandas scipy matplotlib]))

    # lf scope dependencies
    w3m bat atool #poppler
    odt2txt mediainfo file chafa

    # ghidra-bin
  ];

  gtk = {
    enable = true;
    font = {name = "Source Sans Pro 15"; package = pkgs.source-sans-pro;};
    gtk3.bookmarks = let root = "file:///home/ym"; in [
      "${root}/media/music"
      "${root}/to-be-sorted/Torrents"
      "${root}/to-be-sorted"
      "${root}/projects"
      "${root}/yoav/uni"
      "${root}/yoav/school"
      "${root}/.config"
    ];
    iconTheme = {name = "Papirus"; package = pkgs.papirus-icon-theme;};
    theme = {name = "Arc"; package = pkgs.arc-theme;};
  };

  # disabled in favor of the native package manager
  # qt = {enable = true; platformTheme = "gtk";};
  # programs.firefox = {
  #   enable = true;
  #   package = nixos-stable.firefox;
  # };
  programs.emacs = {
    enable = true;
    package = nixos-unstable.emacsGccPgtkWrapped;
    extraPackages = (epkgs: with epkgs; [
      vterm pdf-tools
      # Doom doesn't detect these although I'd like to have them built by nix
      # sqlite emacsql emacsql-mysql emacsql-sqlite emacsql-sqlite3
      ]);
  };
  services.gpg-agent = {
    enable = true;
    # defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
  programs.git = {
    enable = true;
    userName = "Yoav Marco";
    userEmail = "yoavm448@gmail.com";
    extraConfig = {
      pull.rebase = true;
      github.user = "ymarco";
      core.eol = "lf"; # REEEEE
    };
  };

  # MPD
  services.mpd = {
    enable = true;
    # # startWhenNeeded = true; # dont start until firts request
    # dataDir = "/home/ym/dotfiles/.config/mpd/data";
    # dbFile = "/home/ym/dotfiles/.config/mpd/db";
    musicDirectory = "/home/ym/media/music";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "Pulseaudio"
        mixer_type "software"
      }
    '';
    # playlistDirectory = "/home/ym/dotfiles/.config/mpd/playlists";
  };
  services.mpdris2.enable = true; # mpd-mpris2 bridge

  # xsession.enable = true;
  # home.keyboard = {
    # layout = "us,us,il,il";
    # variant = "dvorak,,,";
    # options = [ "caps:swapescape" "compose:ralt" ];
  # };
  # xsession.windowManager.bspwm.enable = true;
  # xsession.windowManager.bspwm.extraConfig = lib.readFile ~/dotfiles/.config/bspwm/bspwmrc;
  # services.sxhkd.enable = true;
  # services.sxhkd.extraConfig = lib.readFile ~/dotfiles/.config/sxhkd/sxhkdrc;
  # services.redshift = {
  #   enable = true;
  #   latitude = "31.5";
  #   longitude = "34.75";
  #   brightness = {day = "1.0"; night = "0.95";};
  #   temperature = {day = 5500; night = 3300;};
  # };
  # services.picom = {
    # enable = true;
    # vSync = true;
    # menuOpacity = "0.9";
    # blur = true;
    # blurExclude = [ "class_g = 'slop'" "class_i = 'polybar'" ];
  # };
  # services.polybar = {
    # enable = true;
    # package = pkgs.polybar.override {
      # mpdSupport = true;
      # pulseSupport = true;
    # };
    # extraConfig = lib.readFile ~/dotfiles/.config/polybar/config-default;
    # script = ''
      # sleep 5s # let bspwm start up
      # MONITOR=HDMI-1 polybar example &
      # sleep 5s # wait for tray to appear on first bar
      # MONITOR=eDP-1 polybar example &
    # '';
  # };
  # services.dunst = {
  #   enable = true;
  #   # iconTheme.package =
  #   settings = {
  #     global = {
  #       monitor = 0;
  #       follow = "mouse";
  #       geometry = "400x5-20+45";
  #       indicate_hidden = true;
  #       shrink = false;
  #       transparency = 25;
  #       notification_height = 0;
  #       separator_height = 2;
  #       padding = 8;
  #       horizontal_padding = 8;
  #       frame_width = 1;
  #       separator_color = "frame";
  #       background = "#2b303b";
  #       frame_color = "#222222";
  #       corner_radius = 6;
  #       foreground = "#c0c5ce";
  #       sort = true; # by urgency
  #       idle_threshold = 120;
  #       font = "Source Sans Pro 15";
  #       line_height = 0;
  #       markup = "full";
  #       format = "<b>%s</b>\\n%b";
  #       alignment = "left";
  #       show_age_threshold = 60;
  #       word_wrap = true;
  #       ellipsize = "middle";
  #       ignore_newline = false;
  #       stack_duplicates = true;
  #       hide_duplicate_count = false;
  #       show_indicators = true;
  #       icon_position = "left";
  #       max_icon_size = 32;
  #       # icon_path = ;
  #       sticky_history = true;
  #       history_length = 20;
  #       dmenu = "${pkgs.rofi} -dmenu -p dunst:";
  #       browser = "${pkgs.firefox} -new-tab";
  #       always_run_script = true;
  #       title = "Dunst";
  #       class = "Dunst";
  #       startup_notification = false;
  #       force_xinerama = false;
  #     };
  #     shortcuts = {
  #       # close = "ctrl+space";
  #       # close_all = "ctrl+shift+space";
  #       history = "mod4 + grave";
  #       context = "shift + mod4 + grave";
  #     };
  #     urgency_low = {
  #       timeout = 7;
  #       background = "#2b303b";
  #       frame_color = "#222222";
  #       foreground = "#c0c5ce";
  #     };
  #     urgency_normal = {
  #       timeout = 8;
  #       background = "#202328";
  #       frame_color = "#222222";
  #       foreground = "#c0c5ce";
  #     };
  #     urgency_critical = {
  #       timeout = 0;
  #       background = "#a00000";
  #       foreground = "#ffffff";
  #       frame_color = "#a00000";
  #     };
  #   };
  # };

  services.udiskie.enable = true;
  services.network-manager-applet.enable = true;
  # services.cbatticon = {
  #   enable = true;
  #   commandCriticalLevel = ''notify-send "Battery at 10%" ""'';
  #   criticalLevelPercent = 10;
  #   # commandLeftClick = "";
  #   updateIntervalSeconds = 60;
  # };
  # services.blueman-applet.enable = true;

  # home-manager manual and list of options
  manual.manpages.enable = true;

  programs.home-manager = {
    enable = true;
    path = "~/.config/nixpkgs/home.nix";
  };
  systemd.user.services = {
    transmission-gtk = {
      Unit.Description = "Transmission-gtk in the background";
      Unit.PartOf = [ "ac-power.target" ];
      Unit.After = [ "ac-power.target" ];
      Unit.Wants = [ "graphical-session-pre.target" ];
      Install.WantedBy = [ "ac-power.target" ];
      Service.ExecStart = ''
        ${pkgs.transmission-gtk}/bin/transmission-gtk --minimized
      '';
    };
  };
}
