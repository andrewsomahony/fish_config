function devshell
  # Run our Nix develop command, using the flake in our home directory
  nix develop --impure ~/dev --command fish
end
