function _prompt_bound_container
    # Run our BASH script to detect if the current directory is
    # bound to a container.
  
    # If we are in a container, we don't need to check this
    # !!! I suppose we should one day, but container-within-container
    # !!! isn't really something that we use at this time

    if not _pure_is_inside_container
      bash ~/dev/container/detect_with_error.sh

      if test $status -eq 0
          echo "$pure_symbol_bound_container_prefix" #(_pure_user_at_host)
      end
    end
end

