{ config, pkgs, host, ...}: {

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.${host.username} = {
    home = host.home;
    shell = pkgs.fish;
  };
  
  environment = {
    systemPackages = with pkgs; [
      fish
      vim
      wget
    ];

    shells = with pkgs; [
      fish
    ]; 
  };
  
  programs.fish.enable = true;
  
  homebrew = {
    enable = true;

    taps = [
      "cirruslabs/cli"
      "felixkratz/formulae"
      "nikitabobko/tap"
    ];

    brews = [
      "cirruslabs/cli/tart"
      "felixkratz/formulae/borders"
    ];
    
    casks = [
      "appcleaner"
      "arc"
      "ghostty"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "font-lilex-nerd-font"
      "nikitabobko/tap/aerospace"
      "raycast"
      "zed"
    ];
    
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
