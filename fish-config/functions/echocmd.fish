function echocmd \
    -d "Echo a command before running it"
    echo "> $argv"
    $argv
end