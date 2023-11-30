function isindex \
    -a s \
    -d "test if arg is a positive non-zero integer"
    
    string match -qr '^[1-9][0-9]*$' $s
end
    