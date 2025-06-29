function _prompt_bound_container
    # Run our BASH script to detect if the current directory is
    # bound to a container.
  
    bash ~/dev/container/detect_with_error.sh

    if test $status -eq 0
        echo "$pure_symbol_bound_container_prefix" #(_pure_user_at_host)
    end
end

