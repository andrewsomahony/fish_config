function localshell
  # Run nix develop in the local directory, which will create the
  # Nix devshell using the "default" shell
  if not test -e ./flake.nix
    echo "No flake.nix file in current directory"
  else
    nix develop --impure .
  end
end
