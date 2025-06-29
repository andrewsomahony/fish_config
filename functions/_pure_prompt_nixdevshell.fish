function _pure_prompt_nixdevshell \
    --description "Indicate if nix develop shell is activated"

    if set --query pure_enable_nixdevshell;
        and test "$pure_enable_nixdevshell" = true;

        set --local shell_level "$SHLVL"
        set --local prefix (_pure_set_color $pure_color_nixdevshell_prefix)$pure_symbol_nixdevshell_prefix
        set --local max (math "$shell_level - 2")
        for level in (seq 0 1 $max 2>/dev/null)
          echo "$prefix"
        end
    end
end
