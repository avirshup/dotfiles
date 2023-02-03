function ec \
    -d "launch emacs client with lazy daemon startup" \
    --wraps="emacsclient"

    emacsclient -cn -a "_lazy_emacs_client.sh -nc" $argv
end
