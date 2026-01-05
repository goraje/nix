{
  config,
  pkgs,
  host,
  lib,
  ...
}:
{
  home = {
    username = host.username;

    homeDirectory = builtins.toString host.home;

    stateVersion = "25.11";

    packages =
      with pkgs;
      [
      ]
      ++ host.userPackages;

    activation.stowDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="/opt/homebrew/bin:$PATH"
      echo "Installing Visual Studio Code extensions ..."
      for ext in ${lib.concatStringsSep " " host.vscodeExtensions}; do
      	code --force --install-extension "$ext"
      done
      cd ${builtins.toString host.dotfilesDirectory}
      echo "Running dotfiles helper script ..."
      ${pkgs.stow}/bin/stow -t ~ --dotfiles -D ${lib.concatStringsSep " " host.stowManagedApps}
      bash helper.sh ${lib.concatStringsSep " " host.stowManagedApps}
      echo "Running stow ..."
      ${pkgs.stow}/bin/stow -t ~ --dotfiles ${lib.concatStringsSep " " host.stowManagedApps}
      echo " Config files were symlinked"
    '';
  };
}
