function df \
    --description 'alias df=df -h' \
    --wraps=df
    command df -h $argv; 
end
