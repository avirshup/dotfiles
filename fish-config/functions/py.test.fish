function py.test \
    --description 'alias py.test=py.test -rEf' \
    --wraps py.test
 command py.test -rEf $argv; 
end
