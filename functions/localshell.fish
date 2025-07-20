# !!! TODO: Need to parse arguments and open the corresponding shell
# !!! instead of "default"
function localshell -a shell_name
  if test -z "$shell_name"
    # Set our default shell name
    set --local shell_name "default"
  end

  # Set our Nix path to the shell we have picked
  set --local shell_path ".#$shell_name"

  # Run nix develop in the local directory
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
        nix develop --impure $shell_path --command fish
      end
    else
      echo "Local shell can only exist on top of a devshell."
    end
  end
end
