{
  config,
  pkgs,
  host,
  ...
}:
{

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.${host.username} = {
    home = builtins.toString host.home;
    shell = pkgs.fish;
  };

  environment = {
    systemPackages =
      with pkgs;
      [
        fish
      ]
      ++ host.systemPackages;

    shells = with pkgs; [
      fish
    ];
  };

  programs.fish.enable = true;

  homebrew = {
    enable = true;

    taps = [
    ]
    ++ host.homebrew.taps;

    brews = [
    ]
    ++ host.homebrew.brews;

    casks = [
    ]
    ++ host.homebrew.casks;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };

  system = {
    primaryUser = host.username;

    defaults = {
      dock = {
        autohide = true;
        show-recents = false;
      };

      finder = {
        ShowPathbar = true;
        FXEnableExtensionChangeWarning = false;
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
      };
    };

    stateVersion = 6;
  };
}
