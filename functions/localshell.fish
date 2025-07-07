function localshell
  # Run nix develop in the local directory, which will create the
  # Nix devshell using the "default" shell
  if not test -e ./flake.nix
    echo "No flake.nix file in current directory."
  else
    set --local shell_level "$SHLVL"
    # If we have a devshell or we're in a devcontainer, then we can run
    # a local shell.
    if test $shell_level -gt 1; or _pure_is_inside_container
      if _pure_is_inside_container
        # If we are in a container, there are strange permissions on the /tmp dir
        # when we are already in a shell.  We need to make our own /tmp dir from scratch
        # and use that with nix develop.
        # !!! This is really stupid and annoying, and Nix seems to just say "don't nest shells",
        # !!! but that defeats the point of containerization if everything has to be in a global
        # !!! shell

        set --local temporary_directory "/tmp/localshell.$(random)"
        mkdir $temporary_directory
        TMPDIR=$temporary_directory nix develop --impure --command fish
      else
        nix develop --impure --command fish
      end
    else
      echo "Local shell can only exist on top of a devshell."
    end
  end
end
