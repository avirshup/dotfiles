function sctl \
    --wraps=supervisorctl \
    --description 'alias sctl=supervisorctl'
  supervisorctl $argv; 
end
