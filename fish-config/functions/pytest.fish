function pytest \
    --description 'alias pytest=pytest -rEf' \
    --wraps=pytest
 command pytest -rEf $argv; 
end
