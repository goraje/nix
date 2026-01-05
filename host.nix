{ pkgs, ... }:
{
  # Update these values before provisioning the system
  # username = "";
  # hostname = "";
  # home = ;
  # dotfilesDirectory = ;

  homebrew = {
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
      "visual-studio-code"
      "zed"
    ];
  };

  systemPackages = with pkgs; [
    home-manager
  ];

  userPackages = with pkgs; [
    aria2
    bat
    fd
    fzf
    gh
    git
    jq
    ncdu
    neovim
    pueue
    ripgrep
    starship
    stow
    tree
    zellij
    zoxide
  ];

  stowManagedApps = [
    "aerospace"
    "fish"
    "ghostty"
    "starship"
    "vscode"
    "zed"
    "zellij"
  ];

  vscodeExtensions = [
    "asvetliakov.vscode-neovim"
    "jnoortheen.nix-ide"
    "miguelsolorio.symbols"
    "raunofreiberg.vesper"
    "subframe7536.custom-ui-style"
  ];
}
