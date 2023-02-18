{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.fht.programs.qutebrowser = with types; {
    enable = mkBoolOpt' false "Whether to enable the Qutebrowser web browser.";
  };

  config = let
    cfg = config.fht.programs.qutebrowser;
  in
    mkIf cfg.enable {
      user.packages = with pkgs; [
        # Custom desktop item so I can enter private mode.
        (makeDesktopItem {
          name = "qutebrowser-private";
          desktopName = "qutebrowser (Private)";
          genericName = "Open a private Qutebrowser window";
          icon = "qutebrowser";
          exec = "${qutebrowser}/bin/qutebrowser -T -s content.private_browsing true";
          categories = ["Network"];
        })
        # For Brave adblock in qutebrowser, which is significantly better than the
        # built-in host blocking. Works on youtube and crunchyroll ads!
        python39Packages.adblock
      ];

      home.programs.qutebrowser = {
        enable = true;
        enableDefaultBindings = true;
        loadAutoconfig = false; # Just dont do this.

        keyBindings = {
          normal = {
            ",s" = "spawn --userscript per-domain-stylesheet.py";
            "xt" = ''config-cycle tabs.show "always" "never"'';
            "xb" = ''config-cycle statusbar.show "always" "never"'';
          };
        };

        searchEngines = {
          # Custom search engines for qutebrowser. Wrappers around websites' search URLS
          # One could hit: `o@ddg {search term(s)}<CR>`
          "@ddg" = "https://duckduckgo.com/?q={}";
          "@yt" = "https://youtube.com/?search={}";
        };

        settings = {
          # Enable auto save, saving my session each 30 minutes.
          # autosave.session automatically restores the opened pages when opening qutebrowser.
          auto_save.interval = 30 * 1000;
          auto_save.session = true;

          # Only accept cookies from the same site origin, unless the said cookie
          # is already set for the domain.
          content.cookies.accept = "no-unknown-3rdparty";

          # Custom user agent to use I guess.
          # You can tweak this to make the browser look like another, alas for the system.
          content.headers.user_agent = "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}";

          # Use Brave ABP-style adblocker, way better.
          # Fallback to host-based adblocking otherwise.
          content.blocking.method = "auto";
          # Sources for the hosts-based adblock.
          content.blocking.hosts.lists = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&mimetype=plaintex"
            # 'https://www.malwaredomainlist.com/hostslist/hosts.txt',
            # 'http://someonewhocares.org/hosts/hosts',
            # 'http://winhelp2002.mvps.org/hosts.zip',
            # 'http://malwaredomains.lehigh.edu/files/justdomains.zip',
          ];

          # Completion panel settings.
          # It's one of qutebrowser's neatest features, allowing a vim-like experience.
          completion.shrink = true;
          completion.height = "50%";

          # Enable images
          content.images = true;

          # Enable WebGL for better performance in websites.
          content.webgl = true;
          # With webgl enable smooth scrolling with j/k keys
          scrolling.smooth = true;

          # Some privacy-respecting/enforcing settings.
          # Just for my sanity so I can stop thinking if a website is doing stuff..
          content.desktop_capture = false; # dont let websites share screen
          content.media.audio_video_capture = false; # same as ^
          content.media.video_capture = false; # same as ^
          content.autoplay = false; # dont autoplay videos
          content.local_storage = true; # WebSQL data storage.

          # Use the cleaner monospace font for all the qutebrowser UI.
          # (completion panel, statusbar, downloads, ...)
          fonts.default_family = "monospace";
          fonts.default_size = "12pt"; # and a more reasoable size.

          # Use zathura instead of PDFjs, waaaaaaaaaaaay better than it.
          content.pdfjs = false;

          # Put every bit of information at the bottom, like neovim/zathura/whatever
          downloads.position = "bottom";
          statusbar.position = "bottom";
          tabs.position = "bottom";

          # Paddings since it looks better.
          # tabs.padding = ''{"bottom":6, "top":6, "left":6, "right":6}'';
          # statusbar.padding = ''{"bottom":6, "top":6, "left":6, "right":6}'';
        };

        # Additional config in python.
        extraConfig = ''
          # Cannot get it to work with nix sadly..
          c.tabs.padding = {"bottom": 6, "top": 6, "left": 6, "right": 6 }
          c.statusbar.padding = {"bottom": 6, "top": 6, "left": 6, "right": 6 }
        '';
      };

      # Enable custom theming I guess.
      fht.theme.targets.qutebrowser.enable = true;
    };
}
