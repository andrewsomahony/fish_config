function localshell
  # Run nix develop in the local directory, which will create the
  # Nix devshell using the "default" shell
  if not test -e ./flake.nix
    echo "No flake.nix file in current directory."
  else
    set --local shell_level "$SHLVL"
    if test $shell_level -gt 1
      nix develop --impure .
    else
      echo "Local shell can only exist on top of a devshell."
    end
  end
end
