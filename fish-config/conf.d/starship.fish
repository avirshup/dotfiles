# A *subset* of everything that starship 1.16.0 produces when you run
# `starship init fish --print-full-init`
# If you do all of it, it breaks iterm integration,
# so I removed everything I'm not gonna use.
# TODO: get rid of starship entirely, generating an ANSI string is not worth all this
#  - transient prompts
#  - vi mode (WHY does my prompt need to know this??)

# ??? Activating this breaks iterm2 integrations
# set -gx STARSHIP_SHELL "fish" 

# ??? not sure what this is or why, but we seem happier without it
builtin functions -e fish_mode_prompt


if type -q starship
    function fish_prompt
        set STARSHIP_CMD_PIPESTATUS $pipestatus
        set STARSHIP_CMD_STATUS $status
        # Account for changes in variable name between v2.7 and v3.0
        set STARSHIP_DURATION "$CMD_DURATION$cmd_duration"
        set STARSHIP_JOBS (count (jobs -p))

        /usr/local/bin/starship prompt --terminal-width="$COLUMNS" --status=$STARSHIP_CMD_STATUS --pipestatus="$STARSHIP_CMD_PIPESTATUS" --keymap=insert --cmd-duration=$STARSHIP_DURATION --jobs=$STARSHIP_JOBS

    end
    
    function fish_right_prompt
        set STARSHIP_CMD_PIPESTATUS $pipestatus
        set STARSHIP_CMD_STATUS $status
        # Account for changes in variable name between v2.7 and v3.0
        set STARSHIP_DURATION "$CMD_DURATION$cmd_duration"
        set STARSHIP_JOBS (count (jobs -p))
        /usr/local/bin/starship prompt --right --terminal-width="$COLUMNS" --status=$STARSHIP_CMD_STATUS --pipestatus="$STARSHIP_CMD_PIPESTATUS" --keymap=insert --cmd-duration=$STARSHIP_DURATION --jobs=$STARSHIP_JOBS

    end
end


set -g VIRTUAL_ENV_DISABLE_PROMPT 1

set -gx STARSHIP_SESSION_KEY (string sub -s1 -l16 (random)(random)(random)(random)(random)0000000000000000) 

echo "  🚀 init starship ✅"    