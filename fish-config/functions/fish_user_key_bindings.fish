function fish_user_key_bindings
    #--- readline-like behavior ---
    bind \e\[A up-or-prefix-search
    bind \e\[B down-or-prefix-search

    # original up/down search are now option+up/down
    bind \e\e\[A up-or-search
    bind \e\e\[B down-or-search

end