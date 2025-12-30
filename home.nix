{ config, pkgs, host, lib, ... }: {
  home = {
    username = host.username;

    homeDirectory = host.home;

    stateVersion = "25.11";
    
    packages = with pkgs; [
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

    activation.stowDotfiles = lib.hm.dag.entryAfter["writeBoundary"] ''
      echo "Running stow to link dotfiles..."
      cd ${config.home.homeDirectory}/dotfiles
      ${pkgs.stow}/bin/stow --dotfiles aerospace fish ghostty starship zed zellij
      echo " Config files were symlinked"
    '';
  };
}
