function devshell
  # !!! TODO: Check the current directory for a flake.nix file, otherwise use
  # !!! the home directory file

  # Run our Nix develop command, using the flake in our home directory
  nix develop --impure ~/dev --command fish
end
